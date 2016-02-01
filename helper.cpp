#include "helper.h"

Helper::Helper(QObject *parent):
    QObject (parent)

{
    context = xkb_context_new((xkb_context_flags)0);
    connection = xcb_connect(NULL,NULL);
    if (!connection || xcb_connection_has_error(connection)) {
        qDebug() << "No xcb connection, aborting...";
        exit(-1);
    }
    int result;
    result = xkb_x11_setup_xkb_extension(connection,
                                         XKB_X11_MIN_MAJOR_XKB_VERSION,
                                         XKB_X11_MIN_MINOR_XKB_VERSION,
                                         XKB_X11_SETUP_XKB_EXTENSION_NO_FLAGS,
                                         NULL, NULL, NULL, NULL);
    if(!result) {
        qDebug() << "Cannot setup xkb-extention, aborting..." ;
        exit(-1);
    }
    deviceId = xkb_x11_get_core_keyboard_device_id(connection);
    keymap = xkb_x11_keymap_new_from_device(context, connection, deviceId,
                                            XKB_KEYMAP_COMPILE_NO_FLAGS);
    state = xkb_x11_state_new_from_device(keymap, connection, deviceId);
    display = XOpenDisplay(0);
}
Helper::~Helper()
{
    xkb_state_unref(state);
    xkb_keymap_unref(keymap);
    xcb_disconnect(connection);
    xkb_context_unref(context);
}

QString Helper::getSymbol(int keycode, int layoutIndex, int keyLevel)
{

    const xkb_keysym_t *arr;
    int size = xkb_keymap_key_get_syms_by_level(keymap,keycode,layoutIndex,keyLevel,&arr);
    qDebug() << size << " = size" ;
    char symbol[100];
    xkb_keysym_to_utf8(arr[0],symbol,100);
    qDebug() << symbol << " = symbol";

    return QString::fromUtf8(symbol);
}

void Helper::fakeKeyPress(const unsigned int code)
{
    XTestFakeKeyEvent(display, code, true, 0);
    XSync(display, False);
}

void Helper::fakeKeyRelease(const unsigned int code)
{
    XTestFakeKeyEvent(display, code, false, 0);
    XSync(display, False);
}
