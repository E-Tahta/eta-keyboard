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
#include "src/adaptor.h"

#include <QtCore/QMetaObject>
#include <QtCore/QByteArray>
#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QVariant>


VirtualKeyboardInterfaceAdaptor::VirtualKeyboardInterfaceAdaptor
(QObject *parent): QDBusAbstractAdaptor(parent)
{
    setAutoRelaySignals(true);
}
VirtualKeyboardInterfaceAdaptor::~VirtualKeyboardInterfaceAdaptor()
{

}

void VirtualKeyboardInterfaceAdaptor::toggle()
{
    QMetaObject::invokeMethod(parent(), "toggleSlot");
}

void VirtualKeyboardInterfaceAdaptor::hide()
{
    QMetaObject::invokeMethod(parent(), "hideSlot");
}

void VirtualKeyboardInterfaceAdaptor::showFromLeft()
{
    QMetaObject::invokeMethod(parent(), "fromLeftSlot");
}

void VirtualKeyboardInterfaceAdaptor::showFromRight()
{
    QMetaObject::invokeMethod(parent(), "fromRightSlot");
}

void VirtualKeyboardInterfaceAdaptor::showFromBottom()
{
    QMetaObject::invokeMethod(parent(), "fromBottomSlot");
}

void VirtualKeyboardInterfaceAdaptor::toggleAutoShow()
{
    QMetaObject::invokeMethod(parent(), "toggleAutoShowSlot");
}
