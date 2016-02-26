#include "localserverinterface.h"
#include "etalocalserver.h"
#include <QFileInfo>
#include <QDir>

LocalServerInterface::LocalServerInterface(QObject *parent) :
    QObject(parent)
{
    server = new EtaLocalServer(this);
    Q_CHECK_PTR(server);
    const QString fullServerName =  QString(QDir::homePath()+"/"+SERVER_NAME);

    QFile file(fullServerName);
    if (file.exists()) {
        file.remove();
    }
    if (server->listen(QDir::homePath()+"/"+SERVER_NAME)) {
        qDebug() << "Listenning";
    } else {
        qDebug() << "Failed to listen";
    }
    connect(server, SIGNAL(showSignal()), this, SLOT(showSlot()));
    connect(server, SIGNAL(hideSignal()), this, SLOT(hideSlot()));
}

void LocalServerInterface::hideSlot()
{
    emit hideSignal();
}
void LocalServerInterface::showSlot()
{
    emit showSignal();
}