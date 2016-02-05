#ifndef XWRAPPER_H
#define XWRAPPER_H
#include <QObject>
#include <QDebug>
#include <xkbcommon/xkbcommon-x11.h>
#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XTest.h>

class XWrapper : public QObject
{
    Q_OBJECT
public:
    explicit XWrapper(QObject *parent = 0);
    ~XWrapper();
    QString getSymbol(int keycode, int layoutIndex, int keyLevel) const;
    void fakeKeyPress(unsigned int code);
    void fakeKeyRelease(unsigned int code);
    int getNumberOfLayouts();
    int getCapslockStatus();
private:
    struct xkb_context *context;
    struct xkb_keymap *keymap;
    struct xkb_state *state;
    xcb_connection_t *connection;
    int32_t deviceId;
    Display *display;

signals:

public slots:
    void onEvent();

};

#endif // XWRAPPER_H
