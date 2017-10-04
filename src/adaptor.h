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
#ifndef ADAPTOR_H
#define ADAPTOR_H

#include <QObject>
#include <QtDBus>

class QByteArray;
template<class T> class QList;
template<class Key, class Value> class QMap;
class QString;
class QStringList;
class QVariant;

class VirtualKeyboardInterfaceAdaptor : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.eta.virtualkeyboard")
    Q_CLASSINFO("D-Bus Introspection", ""
"  <interface name=\"org.eta.virtualkeyboard\">\n"
"    <method name=\"toggle\"/>\n"
"    <method name=\"hide\"/>\n"
"    <method name=\"showFromLeft\"/>\n"
"    <method name=\"showFromRight\"/>\n"
"    <method name=\"showFromBottom\"/>\n"
"    <method name=\"toggleAutoShow\"/>\n"
"    <method name=\"showPinInput\"/>\n"
"    <method name=\"hidePinInput\"/>\n"
"  </interface>\n"
        "")

public:
    VirtualKeyboardInterfaceAdaptor(QObject *parent);
    virtual ~VirtualKeyboardInterfaceAdaptor();


public Q_SLOTS:
    void toggle();
    void hide();
    void showFromLeft();
    void showFromRight();
    void showFromBottom();
    void toggleAutoShow();
    void showPinInput();
    void hidePinInput();


};

#endif // ADAPTOR_H
