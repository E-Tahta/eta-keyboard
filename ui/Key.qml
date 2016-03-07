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

Rectangle {
    id: key

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string activeTextColor: main.activeTextColor
    property string keyText
    property double keyWidth: main.keyWidth
    property double keyHeight: main.keyHeight
    property int keyLevel: main.keyLevel
    property int fontPointSize : main.keyHeight / 4
    property int keyRadius: main.layout == "full" ? main.keyHeight / 10 : main.keyHeight / 8
    property int keyCode: 24
    property bool leVis0: false
    property bool leVis1: false
    property bool leVis2: false
    property bool leVis3: false
    property bool leVis4: false
    property bool highlighted: false
    property double activeOpacity: 1
    property double passiveOpacity: 0.2
    property bool hold: false
    property bool lock: false
    property bool updateTheme: main.updateTheme
    property bool mirror
    property bool capsMirror

    color: ma.containsMouse ? key.keyHoverColor : key.keyColor
    radius: key.keyRadius
    width: key.keyWidth
    height: key.keyHeight

    function btnClicked(){

    }

    function btnPressed(){
        key.color = key.keyPressedColor
        switch (key.keyLevel){
        case 0: lev0.color = key.textPressedColor; break;
        case 1: lev1.color = key.textPressedColor; break;
        case 2: lev2.color = key.textPressedColor; break;
        case 3: lev3.color = key.textPressedColor; break;
        }
        lev4.color = key.textPressedColor
    }

    function btnHovered(){
        if (!key.lock){
            key.color = ma.containsMouse ? key.keyHoverColor : key.keyColor
            lev0.color = key.keyLevel == 0 ? key.activeTextColor : key.textColor
            lev1.color = key.keyLevel == 1 ? key.activeTextColor : key.textColor
            lev2.color = key.keyLevel == 2 ? key.activeTextColor : key.textColor
            lev3.color = key.keyLevel == 3 ? key.activeTextColor : key.textColor
            lev4.color = key.textColor;
        }
    }

    function btnHold(){
        key.hold = true
    }

    function btnReleased(){
        key.hold = false
        btnHovered()
    }

    Text {
        id: lev0
        color: key.keyLevel == 0 ? key.activeTextColor : key.textColor
        font.pointSize: key.fontPointSize ? key.fontPointSize : 5
        text: helper.getSymbol(key.keyCode,main.languageLayoutIndex,0)
        visible: leVis0
        opacity: key.keyLevel == 0 ? key.activeOpacity : key.passiveOpacity
        anchors {
            left: key.left
            bottom: key.bottom
            margins: keyHeight/10
        }
    }

    Text {
        id: lev1
        color: key.keyLevel == 1 ? key.activeTextColor : key.textColor
        font.pointSize: key.fontPointSize ? key.fontPointSize : 5
        text: helper.getSymbol(key.keyCode,main.languageLayoutIndex,1)
        visible: leVis1
        opacity: key.keyLevel == 1 ? key.activeOpacity : key.passiveOpacity
        anchors {
            left: key.left
            top: key.top
            margins: keyHeight/10
        }
    }

    Text {
        id: lev2
        color: key.keyLevel == 2 ? key.activeTextColor : key.textColor
        font.pointSize: key.fontPointSize ? key.fontPointSize : 5
        text: helper.getSymbol(key.keyCode,main.languageLayoutIndex,2)
        visible: leVis2
        opacity: key.keyLevel == 2 ? key.activeOpacity : key.passiveOpacity
        anchors {
            right: key.right
            bottom: key.bottom
            margins: keyHeight/10
        }
    }

    Text {
        id: lev3
        color: key.keyLevel == 3 ? key.activeTextColor : key.textColor
        font.pointSize: key.fontPointSize ? key.fontPointSize : 5
        text: helper.getSymbol(key.keyCode,main.languageLayoutIndex,3)
        visible: leVis3
        opacity: key.keyLevel == 3 ? key.activeOpacity : key.passiveOpacity
        anchors {
            right: key.right
            top: key.top
            margins: keyHeight/10
        }
    }

    Text {
        id: lev4
        color: key.textColor
        font.pointSize: key.fontPointSize ? key.fontPointSize * 3 / 4 : 2
        text: key.keyText
        font.bold: key.highlighted
        font.underline: key.highlighted
        visible: leVis4
        opacity: activeOpacity
        anchors {
            centerIn: key
        }
    }

    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: main.keyHover

        onEntered: {
            btnHovered()
        }

        onExited: {
            btnHovered()
        }

        onPressed: {
            btnPressed()
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

    onUpdateThemeChanged:{
        btnHovered()
    }

    onKeyLevelChanged: {
        btnHovered()
    }

    Component.onCompleted: {

    }
}
