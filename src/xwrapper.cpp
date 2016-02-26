/*****************************************************************************
 *   Copyright (C) 2016 by Yunusemre Senturk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/
#include "src/xwrapper.h"
#include "src/helper.h"



#include <QX11Info>

#define explicit redefine_explicit
#include <xcb/xkb.h>
#undef explicit

#include <xkbcommon/xkbcommon-x11.h>
#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XTest.h>

XWrapper::XWrapper()
{
    kbd = new keyboard;
    kbd->ctx = xkb_context_new((xkb_context_flags)0);
    kbd->conn = QX11Info::connection();
    kbd->device_id = xkb_x11_get_core_keyboard_device_id(kbd->conn);
    kbd->keymap = xkb_x11_keymap_new_from_device(kbd->ctx,
                                                 kbd->conn, kbd->device_id,
                                                 XKB_KEYMAP_COMPILE_NO_FLAGS);
    kbd->state = xkb_x11_state_new_from_device(kbd->keymap,
                                               kbd->conn, kbd->device_id);
    kbd->active_laypout_index = 0;
    display = QX11Info::display();
}

XWrapper::~XWrapper()
{
    xkb_state_unref(kbd->state);
    xkb_keymap_unref(kbd->keymap);
    xkb_context_unref(kbd->ctx);
    delete kbd;
}

void XWrapper::setHelper(Helper *h)
{
    helper = h;
}

int XWrapper::updateKeymap(keyboard *kbd)
{
    struct xkb_keymap *new_keymap;
    struct xkb_state *new_state;

    new_keymap = xkb_x11_keymap_new_from_device(kbd->ctx, kbd->conn,
                                                kbd->device_id,
                                                (xkb_keymap_compile_flags)0);
    if (!new_keymap)
        goto err_out;

    new_state = xkb_x11_state_new_from_device(new_keymap, kbd->conn,
                                              kbd->device_id);
    if (!new_state)
        goto err_keymap;

    if (kbd->keymap)
        qDebug() << "Keymap updated!";

    xkb_state_unref(kbd->state);
    xkb_keymap_unref(kbd->keymap);
    kbd->keymap = new_keymap;
    kbd->state = new_state;
    return 0;

err_keymap:
    xkb_keymap_unref(new_keymap);
err_out:
    return -1;
}

void XWrapper::processXkbEvents(xcb_generic_event_t *gevent, keyboard *kbd)
{
    union xkb_event {
        struct {
            uint8_t response_type;
            uint8_t xkbType;
            uint16_t sequence;
            xcb_timestamp_t time;
            uint8_t deviceID;
        } any;
        xcb_xkb_new_keyboard_notify_event_t new_keyboard_notify;
        xcb_xkb_map_notify_event_t map_notify;
        xcb_xkb_state_notify_event_t state_notify;
    } *event = (union xkb_event *) gevent;

    if (event->any.deviceID != kbd->device_id)
        return;

    switch (event->any.xkbType) {
    case XCB_XKB_NEW_KEYBOARD_NOTIFY:
        if (event->new_keyboard_notify.changed & XCB_XKB_NKN_DETAIL_KEYCODES)
            updateKeymap(kbd);
        helper->layoutChangedCallback();
        qDebug() << "new keyboard notify";
        break;

    case XCB_XKB_MAP_NOTIFY:
        updateKeymap(kbd);
        qDebug() << "map of keyboard notify";
        break;

    case XCB_XKB_STATE_NOTIFY:
        xkb_state_update_mask(kbd->state,
                              event->state_notify.baseMods,
                              event->state_notify.latchedMods,
                              event->state_notify.lockedMods,
                              event->state_notify.baseGroup,
                              event->state_notify.latchedGroup,
                              event->state_notify.lockedGroup);

        for(unsigned int i = 0; i < xkb_keymap_num_layouts(kbd->keymap); i++ )
        {
            if(xkb_state_layout_index_is_active(kbd->state,
                                                i,
                                                XKB_STATE_LAYOUT_LOCKED)
                    && i!=kbd->active_laypout_index) {
                helper->layoutChangedCallback();
                kbd->active_laypout_index = i;
            }
        }

        break;
    }
}

bool XWrapper::nativeEventFilter(const QByteArray &eventType,
                                 void *message, long *) Q_DECL_OVERRIDE
{

    if (eventType == "xcb_generic_event_t") {
        xcb_generic_event_t* ev = static_cast<xcb_generic_event_t *>(message);

        processXkbEvents(ev,kbd);


    }
    return false;
}

int XWrapper::getCapslockStatus()
{
    unsigned n;
    XkbGetIndicatorState(display, XkbUseCoreKbd, &n);
    return ((n & 0x01) == 1);
}

int XWrapper::getNumberOfLayouts()
{
    return xkb_keymap_num_layouts(kbd->keymap);
}

QString XWrapper::getSymbol(int keycode, int layoutIndex, int keyLevel) const
{

    const xkb_keysym_t *arr;
    int size = xkb_keymap_key_get_syms_by_level(kbd->keymap, keycode,
                                                layoutIndex,keyLevel,&arr);
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
