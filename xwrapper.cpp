#include <QSocketNotifier>

#include "xwrapper.h"
/*
#define explicit pad_explicit
#include <xcb/xkb.h>


static int
select_xkb_events_for_device(xcb_connection_t *conn, int32_t device_id)
{

    enum {
        required_events =
            (XCB_XKB_EVENT_TYPE_NEW_KEYBOARD_NOTIFY |
             XCB_XKB_EVENT_TYPE_MAP_NOTIFY |
             XCB_XKB_EVENT_TYPE_STATE_NOTIFY),

        required_nkn_details =
            (XCB_XKB_NKN_DETAIL_KEYCODES),

        required_map_parts =
            (XCB_XKB_MAP_PART_KEY_TYPES |
             XCB_XKB_MAP_PART_KEY_SYMS |
             XCB_XKB_MAP_PART_MODIFIER_MAP |
             XCB_XKB_MAP_PART_EXPLICIT_COMPONENTS |
             XCB_XKB_MAP_PART_KEY_ACTIONS |
             XCB_XKB_MAP_PART_VIRTUAL_MODS |
             XCB_XKB_MAP_PART_VIRTUAL_MOD_MAP),

        required_state_details =
            (XCB_XKB_STATE_PART_MODIFIER_BASE |
             XCB_XKB_STATE_PART_MODIFIER_LATCH |
             XCB_XKB_STATE_PART_MODIFIER_LOCK |
             XCB_XKB_STATE_PART_GROUP_BASE |
             XCB_XKB_STATE_PART_GROUP_LATCH |
             XCB_XKB_STATE_PART_GROUP_LOCK),
    };

    static const xcb_xkb_select_events_details_t details = {
        .affectNewKeyboard = required_nkn_details,
        .newKeyboardDetails = required_nkn_details,
        .affectState = required_state_details,
        .stateDetails = required_state_details,
    };

    xcb_void_cookie_t cookie =
        xcb_xkb_select_events_aux_checked(conn,
                                          device_id,
                                          required_events,    // affectWhich
                                          0,                  // clear
                                          0,                  // selectAll
                                          required_map_parts, // affectMap
                                          required_map_parts, // map
                                          &details);          // details

    xcb_generic_error_t *error = xcb_request_check(conn, cookie);
    if (error) {
        free(error);
        return -1;
    }

    return 0;
}
#undef explicit
*/
XWrapper::XWrapper(QObject *parent):
    QObject(parent)
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
    //select_xkb_events_for_device(connection,deviceId);
    keymap = xkb_x11_keymap_new_from_device(context, connection, deviceId,
                                            XKB_KEYMAP_COMPILE_NO_FLAGS);
    state = xkb_x11_state_new_from_device(keymap, connection, deviceId);
    display = XOpenDisplay(0);

    //int fd = xcb_get_file_descriptor(connection);

    //QSocketNotifier *qsn = new QSocketNotifier(fd, QSocketNotifier::Read, this);

    //connect(qsn,SIGNAL(activated(int)),this,SLOT(onEvent()));

}
XWrapper::~XWrapper()
{
    xkb_state_unref(state);
    xkb_keymap_unref(keymap);
    xcb_disconnect(connection);
    xkb_context_unref(context);
}


void XWrapper::onEvent()
{
    qDebug() << "filedscripter called";
}

int XWrapper::getCapslockStatus()
{
    unsigned n;
    XkbGetIndicatorState(display, XkbUseCoreKbd, &n);
    return ((n & 0x01) == 1);
}

int XWrapper::getNumberOfLayouts()
{
    return xkb_keymap_num_layouts(keymap);
}

QString XWrapper::getSymbol(int keycode, int layoutIndex, int keyLevel) const
{

    const xkb_keysym_t *arr;
    int size = xkb_keymap_key_get_syms_by_level(keymap,keycode,layoutIndex,keyLevel,&arr);
    char symbol[10];
    if (size > 0) {
        xkb_keysym_to_utf8(arr[0],symbol,10);
    }else {
        char space[] = " ";
        strcpy(symbol,space);
    }
    return QString::fromUtf8(symbol);
}

void XWrapper::fakeKeyPress( unsigned int code)
{
    XTestFakeKeyEvent(display, code, true, 0);
    XSync(display, False);
}

void XWrapper::fakeKeyRelease(unsigned int code)
{
    XTestFakeKeyEvent(display, code, false, 0);
    XSync(display, False);
}
