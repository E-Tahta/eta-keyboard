/*****************************************************************************
 *   Copyright (C) 2016 by Hikmet Bas                                        *
 *   <hikmet.bas@pardus.org.tr>                                              *
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

import QtQuick 2.3

// FunctionKey

Key {
    id: key

    property string activeLedColor: "light green"
    property string passiveLedColor: main.keyColor
    property bool clickedFlag: false

    leVis4: true
    keyCode: 66

    Rectangle {
        id: statusLed
        width: keyWidth / 9
        height: statusLed.width
        radius: height / 2
        border.color: main.textColor
        color: key.clickedFlag ? key.activeLedColor : key.passiveLedColor
        anchors {
            top : key.top
            right: key.right
            margins: statusLed.width / 2
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent

        onEntered: {
            btnHovered()
        }

        onExited: {
            btnHovered()
        }

        onPressed: {
            btnPressed()
            helper.fakeKeyPress(66)
            main.settingsVisible = false
        }

        onPressAndHold: {
            btnHold()
        }

        onReleased: {
            btnReleased()
            helper.fakeKeyRelease(66);
        }

        onClicked: {
            btnClicked()
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 5
        onTriggered: {
            key.clickedFlag = helper.getCapslockStatus();
        }
    }

}
