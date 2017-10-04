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
#ifndef XWRAPPER_H
#define XWRAPPER_H

#include <QAbstractNativeEventFilter>
#include <QDebug>
#include <xcb/xcb.h>

typedef struct xcb_connection_t xcb_connection_t;
struct xkb_context;
struct xkb_keymap;
struct xkb_state;
typedef struct _XDisplay Display;
class Helper;

struct keyboard {
    xcb_connection_t *conn;
    struct xkb_context *ctx;
    struct xkb_keymap *keymap;
    struct xkb_state *state;
    int32_t device_id;
    unsigned int active_laypout_index;
};


class XWrapper : public QAbstractNativeEventFilter
{
public:
    XWrapper();
    ~XWrapper();
    QString getSymbol(int keycode, int layoutIndex, int keyLevel) const;
    void fakeKeyPress(unsigned int code);
    void fakeKeyRelease(unsigned int code);
    int getNumberOfLayouts();
    int getCapslockStatus();
    virtual bool nativeEventFilter(const QByteArray &eventType,
                                   void *message, long * );
    void setHelper(Helper *h);
private:
    int updateKeymap(struct keyboard *kbd);
    void processXkbEvents(xcb_generic_event_t *gevent, struct keyboard *kbd);
    keyboard *kbd;
    Display *display;
    Helper *helper;
};

#endif // XWRAPPER_H
