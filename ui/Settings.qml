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
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0

ApplicationWindow {
    flags: Qt.WindowStaysOnBottomHint |
           Qt.FramelessWindowHint |
           Qt.X11BypassWindowManagerHint
    id: settings
    property bool settingsVisible: main.settingsVisible
    property string keyColor
    property int languageIndex: 0
    property int colorIndex: 0
    property bool layout: main.layoutChange
    property bool loaded: main.loaded
    property bool waitFlag : true

    visible: true
    color: main.color
    x: main.x - settings.width + main.spacing
    y: main.y + main.height - settings.height

    function setAndSaveConf(){
        if (main.loaded) {
            main.setAndSave()
        }

    }

    function setLayout(){

        main.releaseAll = !main.releaseAll
        layoutKey.keyText = main.layout
        settings.setAndSaveConf()
    }

    function changeTheme(){


        layoutKey.keyText = main.layout
        if (settings.colorIndex<colorModel.count){
            main.keyColor = colorModel.get(settings.colorIndex).kColor;
            main.textColor = colorModel.get(settings.colorIndex).tColor;
            main.activeTextColor = colorModel.get(settings.colorIndex).atColor;
            main.keyHoverColor = colorModel.get(settings.colorIndex).hColor;
            main.color = colorModel.get(settings.colorIndex).bColor;
            main.updateTheme = !main.updateTheme
            colorKey.keyText = colorModel.get(settings.colorIndex).text
        }
        else {
            settings.colorIndex = 0
            main.keyColor = colorModel.get(settings.colorIndex).kColor;
            main.textColor = colorModel.get(settings.colorIndex).tColor;
            main.activeTextColor = colorModel.get(settings.colorIndex).atColor;
            main.keyHoverColor = colorModel.get(settings.colorIndex).hColor;
            main.color = colorModel.get(settings.colorIndex).bColor;
            main.updateTheme = !main.updateTheme
            colorKey.keyText = colorModel.get(settings.colorIndex).text
        }

        main.themeName = colorKey.keyText

        settings.setAndSaveConf()

    }

    function changeLanguageLayout(button){
        if (button){
            settings.languageIndex++
            if (languageIndex>helper.getNumberOfLayouts())
                settings.languageIndex = 0
        }
        else {
            settings.languageIndex = helper.getCurrentLayoutIndex()
        }
        main.languageLayoutIndex = settings.languageIndex
        helper.setLayout(settings.languageIndex)
        languageKey.keyText = languageModel.count ?
                    languageModel.get(settings.languageIndex).text : ""

        settings.setAndSaveConf()

    }

    ListModel {
        id:languageModel
    }

    ListModel {
        id: colorModel
        ListElement {
            text:"Grey"
            kColor:"#585858"
            tColor:"#dddddd"
            atColor:"white"
            hColor:"#848484"
            bColor: "#010101"
        }
        ListElement {
            text:"Green"
            kColor:"dark green"
            tColor:"white"
            atColor:"white"
            hColor:"green"
            bColor: "#010101"
        }
        ListElement {
            text:"Blue"
            kColor:"#1b50b8"
            tColor:"#fbfcfe"
            atColor:"#fbfcfe"
            hColor:"#3980f4"
            bColor: "#010101"
        }
    }

    Rectangle{
        id: container
        color: main.color

        Column{
            id: col1
            spacing: main.spacing
            anchors{
                top: container.top
                left: container.left
                margins: main.spacing
            }

            Row{
                id: row1
                spacing: main.spacing

                Key{
                    id: languageKey
                    leVis4: true

                    MouseArea {
                        id: ma
                        anchors.fill: parent

                        onEntered: {
                            languageKey.btnHovered()
                        }

                        onExited: {
                            languageKey.btnHovered()
                        }

                        onPressed: {
                            languageKey.btnPressed()
                            settings.waitFlag = false
                            changeLanguageLayout(true)

                        }

                        onPressAndHold: {
                            languageKey.btnHold()
                        }

                        onReleased: {
                            languageKey.btnReleased()
                            settings.waitFlag = true
                        }

                        onClicked: {
                            languageKey.btnClicked()
                        }
                    }
                }

                Key{
                    id: colorKey
                    leVis4: true

                    MouseArea {
                        id: ma1
                        anchors.fill: parent

                        onEntered: {
                            colorKey.btnHovered()
                        }

                        onExited: {
                            colorKey.btnHovered()
                        }

                        onPressed: {
                            colorKey.btnPressed()
                            settings.colorIndex++
                            changeTheme()
                        }

                        onPressAndHold: {
                            languageKey.btnHold()
                        }

                        onReleased: {
                            languageKey.btnReleased()
                        }

                        onClicked: {
                            languageKey.btnClicked()
                        }
                    }
                }

                Key{
                    id: layoutKey
                    leVis4: true

                    MouseArea {
                        id: ma2
                        anchors.fill: parent

                        onEntered: {
                            layoutKey.btnHovered()
                        }

                        onExited: {
                            layoutKey.btnHovered()
                        }

                        onPressed: {
                            layoutKey.btnPressed()
                        }

                        onPressAndHold: {
                            layoutKey.btnHold()
                        }

                        onReleased: {
                            layoutKey.btnReleased()
                            if (main.layout == "full") {
                                main.layout = "tablet"
                            }
                            else {
                                main.layout = "full"
                            }
                            settings.setLayout()
                        }

                        onClicked: {
                            layoutKey.btnClicked()
                        }
                    }
                }
            }

            Row{
                id: r2
                spacing: main.spacing

                Key{
                    id: scaleDown
                    leVis4: true
                    keyText: "-"

                    MouseArea {
                        id: ma3
                        anchors.fill: parent

                        onEntered: {
                            scaleDown.btnHovered()
                        }

                        onExited: {
                            scaleDown.btnHovered()
                        }

                        onPressed: {
                            scaleDown.btnPressed()
                        }
                        onPressAndHold: {
                            scaleDown.btnHold()
                        }

                        onReleased: {
                            if (main.scale>0.5) {
                                main.scale-=0.1
                            }

                            settings.setAndSaveConf()
                        }

                        onClicked: {
                            scaleDown.btnClicked()
                        }
                    }
                }

                Key{
                    id: scaleUp
                    leVis4: true
                    keyText: "+"

                    MouseArea {
                        id: ma4
                        anchors.fill: parent

                        onEntered: {
                            scaleUp.btnHovered()
                        }

                        onExited: {
                            scaleUp.btnHovered()
                        }

                        onPressed: {
                            scaleUp.btnPressed()
                        }

                        onPressAndHold: {
                            scaleUp.btnHold()
                        }

                        onReleased: {
                            if (main.scale<1.5) {
                                main.scale+=0.1
                            }

                            settings.setAndSaveConf()
                        }

                        onClicked: {
                            scaleDown.btnClicked()
                        }
                    }
                }

                Key{
                    id: autoShowKey
                    leVis4: true
                    keyText: "OTO"
                    highlighted: main.autoShowToggle ? true : false
                    activeOpacity: main.autoShowToggle ? 1 : 0.2

                    MouseArea {
                        id: ma6
                        anchors.fill: parent

                        onPressed: {
                            autoShowKey.btnPressed()
                            main.autoShowToggle = !main.autoShowToggle

                            settings.setAndSaveConf()
                        }

                        onPressAndHold: {
                            autoShowKey.btnHold()
                        }

                        onReleased: {
                            autoShowKey.btnReleased()
                        }

                        onClicked: {
                            autoShowKey.btnClicked()
                        }
                    }
                }
            }
        }
    }

    NumberAnimation {
        id: showSettings;
        target: settings;
        property: "width";
        to:main.m_settings_width
        duration: 300
        easing.type: Easing.OutQuad
    }

    NumberAnimation {
        id: hideSettings;
        target: settings;
        property: "width";
        to: 0 ;
        duration: 300;
        easing.type: Easing.OutQuad
    }

    onLayoutChanged: {
        languageModel.clear()
        for(var i = 0; i< helper.getNumberOfLayouts();i++) {
            languageModel.append({text:helper.getLayoutName(i)})
        }
        if (settings.waitFlag)
        changeLanguageLayout(false)
    }

    onSettingsVisibleChanged: {
        if(main.settingsVisible) {
            showSettings.start()
        }
        else {
            hideSettings.start()
        }
    }

    onLoadedChanged: {
        switch (main.themeName){
        case "Grey": settings.colorIndex = 0
            break;
        case "Green": settings.colorIndex = 1
            break;
        case "Blue": settings.colorIndex = 2
        }
        changeTheme()
        changeLanguageLayout(false)
        setLayout()

        settings.setAndSaveConf()
    }

    Component.onCompleted: {
        for(var i = 0; i< helper.getNumberOfLayouts();i++) {
            languageModel.append({text:helper.getLayoutName(i)})
        }
        changeLanguageLayout(false)
        hideSettings.start()

    }
}
