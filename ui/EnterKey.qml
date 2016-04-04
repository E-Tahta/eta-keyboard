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

// EnterKey

Item {
    id: key

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keyText
    property double keyWidth: main.keyWidth
    property double keyHeight: main.keyHeight
    property int keyLevel: main.keyLevel
    property int fontPointSize: main.keyHeight / 4
    property int keyRadius: main.keyHeight / 10
    property int keyCode: 36
    property bool hold: false
    property bool pressed: false
    property bool updateTheme: main.updateTheme
    property bool entered: false
    property bool keyHoverTimerTriggered: main.keyHoverTimerTriggered


    width: keyWidth * 3 / 2
    height: keyHeight * 2 + main.spacing

    function btnClicked(){

    }

    function btnPressed(){
        key.pressed = true
        head.color = key.keyPressedColor
        foot.color = key.keyPressedColor
        headText.color = key.textPressedColor
    }

    function btnHovered(){
        if (!key.hold){
            if (key.entered && main.keyHoverTimer){
                head.color = key.keyHoverColor
                headText.color = key.textColor
                foot.color = key.keyHoverColor
            }
            else {
                head.color = key.keyColor
                headText.color = key.textColor
                foot.color = key.keyColor
            }
        }
    }

    function btnHold(){
        key.hold = true
    }

    function btnReleased(){
        key.hold = false
        key.pressed = false
        btnHovered()
    }

    Rectangle{
        id: head
        color: ma.containsMouse ? key.keyHoverColor : key.keyColor
        radius: key.keyRadius
        height: key.keyHeight
        width: key.width + main.spacing
        z: 10

        Text {
            id: headText
            color: key.textColor
            font.pointSize: key.fontPointSize ?  key.fontPointSize : 5
            text: "\u23CE Enter"
            anchors {
                centerIn: head
            }
        }

        MouseArea{
            id: ma
            anchors.fill: parent
            hoverEnabled: main.keyHover

            onEntered: {
                main.keyHoverTimer = true
                key.entered = true
                btnHovered()
            }

            onExited: {
                main.keyHoverTimer = true
                key.entered = false
                btnHovered()
            }

            onPressed: {
                btnPressed()
                main.keyClicked(key.keyCode)
            }

            onPressAndHold: {
                btnHold()
            }

            onReleased: {
                btnReleased()
            }

            onClicked: {

            }
        }
    }

    Rectangle{
        id: foot
        color: ma1.containsMouse ? key.keyHoverColor : key.keyColor
        radius: key.keyRadius
        width: key.keyWidth * 5 / 4 + main.spacing
        height: key.height
        anchors {
            top: head.top
            right: head.right
        }

        MouseArea{
            id: ma1
            anchors.fill: parent
            hoverEnabled: main.keyHover

            onEntered: {
                main.keyHoverTimer = true
                key.entered = true
                btnHovered()
            }

            onExited: {
                main.keyHoverTimer = true
                key.entered = false
                btnHovered()
            }

            onPressed: {
                btnPressed()
                main.keyClicked(key.keyCode)
            }

            onPressAndHold: {
                btnHold()
            }

            onReleased: {
                btnReleased()
            }

            onClicked: {

            }
        }
    }

    onUpdateThemeChanged:{
        if (!key.pressed) {
            btnHovered()
        }
    }

    onKeyHoverTimerTriggeredChanged: {
        btnHovered()
    }
}
