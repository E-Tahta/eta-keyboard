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
#ifndef VKDBUSINTERFACE_H
#define VKDBUSINTERFACE_H

#include <QObject>

class VkDbusInterface : public QObject
{
    Q_OBJECT
public:
    explicit VkDbusInterface(QObject *parent = 0);
signals:
    void show(bool password);
    void toggle();
    void hide();    
    void showFromLeft();
    void showFromRight();
    void showFromBottom();
    void toggleAutoShow();
    void showPinInput();
    void hidePinInput();
public Q_SLOTS:
    void showSlot(bool password);
    void toggleSlot();
    void hideSlot();
    void fromLeftSlot();
    void fromRightSlot();
    void fromBottomSlot();
    void toggleAutoShowSlot();
    void showPinInputSlot();
    void hidePinInputSlot();
};

#endif // VKDBUSINTERFACE_H
