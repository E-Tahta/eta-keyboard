/*****************************************************************************
 *   Copyright (C) 2016 by Hikmet Bas                                        *
 *   <hikmet.bask@pardus.org.tr>                                             *
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

Rectangle {

    id: imgKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string imgSource
    property bool isAnimated: false
    property int keyWidth
    property int keyHeight: main.keyHeight

    property bool open: false
    property int angle: 90


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10


    property bool hold: false
    property bool entered: false
    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: imgKey.imgSource


        RotationAnimation on rotation {
            onStarted: {
                if (imgKey.open)
                    imgKey.angle = 90;
                else
                    imgKey.angle = 0
                imgKey.open = !imgKey.open;
            }
            id: rotationAnimation
            from: 0 + imgKey.angle
            to: 90 - imgKey.angle
            duration: 500
            easing.type: Easing.OutBounce
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            imgKey.color = keyHoverColor
            imgKey.entered = true
        }

        onExited: {
            if (!imgKey.hold){
                imgKey.color = keyColor

            }
            imgKey.entered = false
        }

        onPressed: {
            imgKey.color = keyPressedColor

            console.log(imgSource)

        }
        onPressAndHold: {
            imgKey.color = keyPressedColor

            imgKey.hold = true
            console.log(imgKey.hold);

        }
        onReleased: {
            imgKey.color = hoveredChanged() ? keyColor : keyHoverColor

            imgKey.hold = false
            if (!imgKey.entered){
                imgKey.color = keyColor
            }

        }
        onClicked: if(imgKey.isAnimated)rotationAnimation.start()
    }
}
