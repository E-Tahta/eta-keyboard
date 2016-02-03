#ifndef HELPER_H
#define HELPER_H
#include <QObject>
#include <QDebug>
#include <xkbcommon/xkbcommon-x11.h>
#include <X11/Xlib.h>
#include <X11/extensions/XTest.h>
#include <QDBusConnection>
#include <QDBusInterface>

class Helper : public QObject
{
    Q_OBJECT
public:
    explicit Helper(QObject *parent = 0);
    ~Helper();
    QString layout();
    Q_INVOKABLE QString getSymbol(int keycode, int layoutIndex, int keyLevel);
    Q_INVOKABLE void fakeKeyPress(const unsigned int code);
    Q_INVOKABLE void fakeKeyRelease(const unsigned int code);
    Q_INVOKABLE int getNumberOfLayouts();
    Q_INVOKABLE QString getLayoutName(int layoutIndex);
    Q_INVOKABLE QString getCurrentLayout();
    Q_INVOKABLE void setLayout(const QString &layout);
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
