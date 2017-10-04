/*****************************************************************************
 *   Copyright (C) 2016 by Yunusemre Senturk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/
#include "src/etalocalserver.h"
#include <QLocalSocket>

EtaLocalServer::EtaLocalServer(QObject *parent) :
    QLocalServer(parent)
{
}

void EtaLocalServer::incomingConnection(quintptr socketDescriptor)
{    
    if (m_clients.length() < MAX_CILENT) {
        QLocalSocket *client = new QLocalSocket;
        client->setSocketDescriptor(socketDescriptor);
        connect(client, SIGNAL(readyRead()),this, SLOT(onReadyRead()));
        connect(client, SIGNAL(disconnected()),client, SLOT(deleteLater()));
        connect(client, SIGNAL(disconnected()),this, SLOT(onDisconnected()));
        m_clients.append(client);
        qDebug() << "A client connected";
    }
}

EtaLocalServer::~EtaLocalServer()
{
    int i;
    for(i = 0; i < m_clients.length(); ++i) {
        m_clients[i]->disconnectFromServer();
        delete m_clients[i];
    }
}

void EtaLocalServer::onReadyRead()
{        
    QLocalSocket *client = (QLocalSocket*)sender();
    char data[MAX_DATA_LEN];
    client->readLine(data, MAX_DATA_LEN);

    switch (data[0]) {
    case '1':
        if(data[2] == '1') {
            passwordSlot();
            qDebug() << "password area detection from python over qlocalsocket";
        } else {
            showSlot();
        }
        break;
    case '2':
        hideSlot();        
        break;
    default:
        qDebug() << "unknown value recieved";
        break;
    }
}

void EtaLocalServer::disconnectClients()
{
    int i;
    for(i = 0; i < m_clients.length(); ++i)
    {
        m_clients[i]->disconnectFromServer();
    }

    m_clients.clear();
}
void EtaLocalServer::onDisconnected()
{
    QLocalSocket *client = (QLocalSocket*)sender();
    m_clients.removeAll(client);
}

void EtaLocalServer::showSlot()
{
    emit showSignal();
}

void EtaLocalServer::hideSlot()
{
    emit hideSignal();
}

void EtaLocalServer::passwordSlot()
{
    emit passwordSignal();
}
