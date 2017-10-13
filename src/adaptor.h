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

class VirtualKeyboardInterfaceAdaptor : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.eta.virtualkeyboard")
public:
    VirtualKeyboardInterfaceAdaptor(QObject *parent);
public slots:
    Q_NOREPLY void show(bool password);
    Q_NOREPLY void toggle();
    Q_NOREPLY void hide();
    Q_NOREPLY void showFromLeft();
    Q_NOREPLY void showFromRight();
    Q_NOREPLY void showFromBottom();
    Q_NOREPLY void toggleAutoShow();
    Q_NOREPLY void showPinInput();
    Q_NOREPLY void hidePinInput();
};

#endif // ADAPTOR_H
