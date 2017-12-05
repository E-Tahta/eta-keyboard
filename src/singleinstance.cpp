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
#include "src/singleinstance.h"
#include <QLocalSocket>
#include <QApplication>

SingleInstance::SingleInstance(QObject *parent) : QObject(parent)
{    
    connect(&mServer, SIGNAL(newConnection()),this,SLOT(newConnection()));
}

bool SingleInstance::listen(QString name)
{
    mServer.removeServer(name);
    //mServer.setSocketOptions(QLocalServer::WorldAccessOption);
    return mServer.listen(name);
}

bool SingleInstance::hasPrevious(QString name, QStringList arg)
{    
    QLocalSocket socket;
    socket.connectToServer(name, QLocalSocket::ReadWrite);

    if(socket.waitForConnected())
    {
        qDebug("Sending args to previous instance");
        QByteArray buffer;
        foreach(QString item, arg)
        {
            buffer.append(item + "\n");
        }
        socket.write(buffer);
        socket.waitForBytesWritten();
        return true;
    }
    return false;
}

void SingleInstance::newConnection()
{
    emit newInstance();
    mSocket = mServer.nextPendingConnection();
    connect(mSocket,SIGNAL(readyRead()),this,SLOT(readyRead()));
}

void SingleInstance::readyRead()
{   
    mSocket->deleteLater();
}

