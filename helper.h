#ifndef HELPER_H
#define HELPER_H
#include <QObject>
#include <QDebug>
#include <QDBusInterface>
#include "xwrapper.h"
#include "vkdbusinterface.h"

class Helper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString layout READ layout
               NOTIFY hideCalled
               NOTIFY layoutChanged
               NOTIFY showFromLeftCalled
               NOTIFY showFromRightCalled
               NOTIFY showFromBottomCalled
               NOTIFY toggleCalled
               NOTIFY toggleAutoShowCalled)
public:
    explicit Helper(QObject *parent = 0);
    ~Helper();
    QString layout() const;
    Q_INVOKABLE QString getSymbol(int keycode, int layoutIndex, int keyLevel) const;
    Q_INVOKABLE void fakeKeyPress(unsigned int code);
    Q_INVOKABLE void fakeKeyRelease(unsigned int code);
    Q_INVOKABLE int getNumberOfLayouts();
    Q_INVOKABLE QString getLayoutName(int layoutIndex) const;
    Q_INVOKABLE QString getCurrentLayout() const;
    Q_INVOKABLE void setLayout(const QString &layout);
    Q_INVOKABLE int getCapslockStatus();
private:
    XWrapper *xw;
    VkDbusInterface *vkdi;
    QDBusInterface *interface;

public slots:
    void layoutChangedSlot();
signals:
    void hideCalled();
    void layoutChanged();
    void showFromLeftCalled();
    void showFromRightCalled();
    void showFromBottomCalled();
    void toggleCalled();
    void toggleAutoShowCalled();
};

#endif // HELPER_H
