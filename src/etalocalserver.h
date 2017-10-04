#ifndef ETALOCALSERVER_H
#define ETALOCALSERVER_H

#include <QList>
#include <QLocalServer>

#define MAX_CILENT (3)
#define MAX_DATA_LEN (15)

class QLocalSocket;

class EtaLocalServer : public QLocalServer
{
    Q_OBJECT
public:
    explicit EtaLocalServer(QObject *parent = 0);
    ~EtaLocalServer();
signals:
    void hideSignal();
    void showSignal();
    void passwordSignal();
public slots:
    void disconnectClients();
protected:
    void incomingConnection(quintptr socketDescriptor);
private slots:
    void onReadyRead();
    void onDisconnected();
    void hideSlot();
    void showSlot();
    void passwordSlot();

private:
    QList<QLocalSocket*> m_clients;

};

#endif // ETALOCALSERVER_H
