#include "src/singleinstance.h"

SingleInstance::SingleInstance(QObject *parent) : QObject(parent)
{
    connect(&mServer, SIGNAL(newConnection()),this,SLOT(newConnection()));
}

SingleInstance::~SingleInstance()
{

}

bool SingleInstance::listen(QString name)
{
    mServer.removeServer(name);
    return mServer.listen(name);
}

bool SingleInstance::hasPrevious(QString name, QStringList arg)
{

    qDebug() << "Checking for previous instance...";
    QLocalSocket socket;
    socket.connectToServer(name, QLocalSocket::ReadWrite);

    if(socket.waitForConnected())
    {
        qDebug() << "Sending args to previous instance...";
        QByteArray buffer;

        foreach(QString item, arg)
        {
            buffer.append(item + "\n");
        }
        socket.write(buffer);
        socket.waitForBytesWritten();
        return true;
    }

    qDebug() << socket.errorString();

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

