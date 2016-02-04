#ifndef HELPER_H
#define HELPER_H
#include <QObject>
#include <QDebug>
#include <xkbcommon/xkbcommon-x11.h>
#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XTest.h>
#include <QDBusConnection>
#include <QDBusInterface>


class Helper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NOTIFY layoutChanged) //TODO : fix invalid property
public:
    explicit Helper(QObject *parent = 0);
    ~Helper();
    Q_INVOKABLE QString getSymbol(int keycode, int layoutIndex, int keyLevel) const;
    Q_INVOKABLE void fakeKeyPress(const unsigned int code);
    Q_INVOKABLE void fakeKeyRelease(const unsigned int code);
    Q_INVOKABLE int getNumberOfLayouts();
    Q_INVOKABLE QString getLayoutName(int layoutIndex) const;
    Q_INVOKABLE QString getCurrentLayout() const;
    Q_INVOKABLE void setLayout(const QString &layout);
    Q_INVOKABLE int getCapslockStatus();
private:
    struct xkb_context *context;
    struct xkb_keymap *keymap;
    struct xkb_state *state;
    xcb_connection_t *connection;
    int32_t deviceId;
    Display *display;
    QDBusInterface *interface;
public slots:
    void layoutChangedSlot();
signals:
    void layoutChanged();
};

#endif // HELPER_H
