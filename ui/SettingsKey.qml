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

// SettingsKey

Key {
    id: key
    property int angle: 90
    property bool settingsVisible: main.settingsVisible

    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: "Images/gear.svg"
        smooth: true
        mipmap: true

        RotationAnimation on rotation {
            id: rotationAnimation
            from: 0 + key.angle
            to: 90 - key.angle
            duration: 300
            easing.type:  Easing.OutQuad
            onStarted: {
                settings.visible = true
            }
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
            if (!helper.isLogin()) {
                btnPressed()
                if (!main.settingsVisible){
                    key.angle = 90
                    main.settingsVisible = true
                }
                else{
                    key.angle = 0
                    main.settingsVisible = false
                }
                rotationAnimation.start()
                main.releaseAllSticky()
            }
        }

        onPressAndHold: {
            btnHold()
        }

        onReleased: {
            btnReleased()
        }

        onClicked: {
            key.btnClicked()

        }
    }

    onSettingsVisibleChanged: {
        if (main.settingsVisible) {
            key.angle = 90
        }
        else {
            key.angle = 0
        }

        rotationAnimation.start()
    }
}
