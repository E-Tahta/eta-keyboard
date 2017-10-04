#ifndef LOCALSERVERINTERFACE_H
#define LOCALSERVERINTERFACE_H

#include "src/etalocalserver.h"
#include <QObject>

class EtaLocalServer;

#define SERVER_NAME ".eta-keyboard"

class LocalServerInterface : public QObject
{
    Q_OBJECT
public:
    explicit LocalServerInterface(QObject *parent = 0);
private:
    EtaLocalServer *server;
signals:
    void hideSignal();
    void showSignal();
    void passwordSignal();
public slots:
    void hideSlot();
    void showSlot();
    void passwordSlot();
};

#endif // LOCALSERVERINTERFACE_H
