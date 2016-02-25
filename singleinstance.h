#ifndef SINGLEINSTANCE_H
#define SINGLEINSTANCE_H

#include <QObject>
#include <QDebug>
#include <QLocalServer>
#include <QLocalSocket>

class SingleInstance : public QObject
{
    Q_OBJECT
public:
    explicit SingleInstance(QObject *parent = 0);
    ~SingleInstance();

    /**
     * @brief Listen for connections
     * @param name
     */
    void listen(QString name);

    /**
     * @brief Determines if a previous instance exists
     * @param name
     * @param arg
     * @return
     */
    bool hasPrevious(QString name, QStringList arg);

signals:

    /**
     * @brief Emitted when a new instance is launched
     */
    void newInstance();


public slots:

    /**
     * @brief Called when a new instance is opened
     */
    void newConnection();

    /**
     * @brief Read from the socket
     */
    void readyRead();

private:
    /**
     * @brief Local socket
     */
    QLocalSocket* mSocket;

    /**
     * @brief The server
     */
    QLocalServer mServer;
};

#endif // SINGLEINSTANCE_H
