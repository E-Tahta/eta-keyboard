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
#include "xkblibwrapper.h"

#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/XKBlib.h>
#include <X11/extensions/XKBrules.h>

XKBLibWrapper::XKBLibWrapper(QObject *parent) :
    QObject(parent)
{
    display = QX11Info::display();
}

void XKBLibWrapper::setLayout(unsigned int layoutIndex)
{
    if (XkbLockGroup(display, XkbUseCoreKbd, layoutIndex)) {
        qDebug() << "Attempt to change layout group to " << layoutIndex;
        XkbStateRec xkbState;
        XkbGetState( display, XkbUseCoreKbd, &xkbState );
        unsigned int group = xkbState.group;
        qDebug() << "Current group after attempting to change layout group is " << group;
    } else {
        qDebug() << "Failed to change layout group to " << layoutIndex;
    }
}

QString XKBLibWrapper::getCurrentLayout()
{
    XkbStateRec xkbState;
    XkbGetState( display, XkbUseCoreKbd, &xkbState );
    unsigned int group = xkbState.group;
    return getLayoutName(group);
}

QString XKBLibWrapper::getLayoutName(unsigned int layoutIndex)
{
    QList<LayoutUnit> layoutUnits = getLayoutsList();
    return layoutUnits.at(layoutIndex).toString();
}

QList<LayoutUnit> XKBLibWrapper::getLayoutsList()
{

    XkbConfig xkbConfig;
        QList<LayoutUnit> lus;
        LayoutUnit lu;
        if( getGroupNames( &xkbConfig) ) {
            for(int i=0; i<xkbConfig.layouts.size(); i++) {
                QString layout(xkbConfig.layouts[i]);
                QString variant;
                if( i<xkbConfig.variants.size() && ! xkbConfig.variants[i].isEmpty() ) {
                    variant = xkbConfig.variants[i];
                }
                lu.layout = layout;
                lu.variant = variant;
                lus.append(lu);
            }
        }
        else {
            qDebug() << "Failed to get layout groups from X server";
        }
        return lus;
}

QString LayoutUnit::toString() const
{
    if( variant.isEmpty() )
        return layout;

    return layout + "("+variant+")";
}

bool XKBLibWrapper::getGroupNames(XkbConfig* xkbConfig)
{
    Display *display = XOpenDisplay(NULL);
    static const char* OPTIONS_SEPARATOR = ",";

    Atom real_prop_type;
    int fmt;
    unsigned long nitems, extra_bytes;
    char *prop_data = NULL;
    Status ret;

    Atom rules_atom = XInternAtom(display, _XKB_RF_NAMES_PROP_ATOM, False);

    /* no such atom! */
    if (rules_atom == None) {       /* property cannot exist */
        qDebug() << "Failed to fetch layouts from server:" << "could not find the atom" << _XKB_RF_NAMES_PROP_ATOM;
        return false;
    }

    ret = XGetWindowProperty(display,
            DefaultRootWindow(display),
            rules_atom, 0L, _XKB_RF_NAMES_PROP_MAXLEN,
            False, XA_STRING, &real_prop_type, &fmt,
            &nitems, &extra_bytes,
            (unsigned char **) (void *) &prop_data);

    if (ret != Success) {
        qDebug() << "Failed to fetch layouts from server:" << "Could not get the property";
        return false;
    }

    if ((extra_bytes > 0) || (real_prop_type != XA_STRING) || (fmt != 8)) {
        if (prop_data)
            XFree(prop_data);
        qDebug() << "Failed to fetch layouts from server:" << "Wrong property format";
        return false;
    }

    QStringList names;
    for(char* p=prop_data; p-prop_data < (long)nitems && p != NULL; p += strlen(p)+1) {
        names.append( p );

    }

    if( names.count() < 4 ) { //{ rules, model, layouts, variants, options }
        XFree(prop_data);
        return false;
    }


        QStringList layouts = names[2].split(OPTIONS_SEPARATOR);
        QStringList variants = names[3].split(OPTIONS_SEPARATOR);

        for(int ii=0; ii<layouts.count(); ii++) {
            xkbConfig->layouts << (layouts[ii] != NULL ? layouts[ii] : "");
            xkbConfig->variants << (ii < variants.count() && variants[ii] != NULL ? variants[ii] : "");
        }
        //qDebug() << "Fetched layout groups from X server:"
        //        << "\tlayouts:" << xkbConfig->layouts
        //        << "\tvariants:" << xkbConfig->variants;


    XFree(prop_data);
    return true;
}
