#ifndef LOCALSERVERINTERFACE_H
#define LOCALSERVERINTERFACE_H

#include <QObject>
#include "src/etalocalserver.h"

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
public slots:
    void hideSlot();
    void showSlot();
};

#endif // LOCALSERVERINTERFACE_H
