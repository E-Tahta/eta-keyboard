#include "src/etalocalserver.h"
#include <QtNetwork/QLocalSocket>
#include <QtNetwork/QLocalServer>

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
