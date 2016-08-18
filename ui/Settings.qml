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
    property variant colorsCurrentArr: ["Grey","Green","Blue","Brown","White"]
    property variant colorsTr: ["Gri","Yeşil","Mavi","Kahve","Beyaz"]
    property variant colorsUs: ["Grey","Green","Blue","Brown","White"]
    property variant colorsAra: ["رمادي","أخضر","أزرق","بنى","أبيض"]


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
            main.keyPressedColor = colorModel.get(settings.colorIndex).pColor;
            main.keyColor = colorModel.get(settings.colorIndex).kColor;
            main.textColor = colorModel.get(settings.colorIndex).tColor;
            main.activeTextColor = colorModel.get(settings.colorIndex).atColor;
            main.activeTextColor0 =
                    colorModel.get(settings.colorIndex).atColor0;
            main.activeTextColor1 =
                    colorModel.get(settings.colorIndex).atColor1;
            main.activeTextColor2 =
                    colorModel.get(settings.colorIndex).atColor2;
            main.activeTextColor3 =
                    colorModel.get(settings.colorIndex).atColor3;
            main.keyHoverColor = colorModel.get(settings.colorIndex).hColor;
            main.color = colorModel.get(settings.colorIndex).bColor;

            main.updateTheme = !main.updateTheme
           main.themeName = settings.colorIndex

            colorKey.keyText = settings.colorsCurrentArr[settings.colorIndex]


        }
        else {
            settings.colorIndex = 0
            main.keyPressedColor = colorModel.get(settings.colorIndex).pColor;
            main.keyColor = colorModel.get(settings.colorIndex).kColor;
            main.textColor = colorModel.get(settings.colorIndex).tColor;
            main.activeTextColor = colorModel.get(settings.colorIndex).atColor;
            main.activeTextColor0 =
                    colorModel.get(settings.colorIndex).atColor0;
            main.activeTextColor1 =
                    colorModel.get(settings.colorIndex).atColor1;
            main.activeTextColor2 =
                    colorModel.get(settings.colorIndex).atColor2;
            main.activeTextColor3 =
                    colorModel.get(settings.colorIndex).atColor3;
            main.keyHoverColor = colorModel.get(settings.colorIndex).hColor;
            main.color = colorModel.get(settings.colorIndex).bColor;
            main.updateTheme = !main.updateTheme
            main.themeName = settings.colorIndex
            colorKey.keyText = settings.colorsCurrentArr[settings.colorIndex]
        }

        settings.setAndSaveConf()

    }

    function changeLanguageLayout(button){
        if (button){
            settings.languageIndex++
            if (languageIndex>=helper.getNumberOfLayouts())
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
            atColor0:"white"
            atColor1:"white"
            atColor2:"light green"
            atColor3:"white"
            hColor:"#848484"
            bColor:"#010101"
            pColor: "white"
        }
        ListElement {
            text:"Green"
            kColor:"#2a6f2c"
            tColor:"white"
            atColor:"white"
            atColor0:"white"
            atColor1:"white"
            atColor2:"#f4ff0f"
            atColor3:"white"
            hColor:"#66bb5d"
            bColor:"#010101"
            pColor: "white"
        }
        ListElement {
            text:"Blue"
            kColor:"#0e5b83"
            tColor:"#fbfcfe"
            atColor:"#fbfcfe"
            atColor0:"white"
            atColor1:"white"
            atColor2:"#f4ff0f"
            atColor3:"white"
            hColor:"#3980f4"
            bColor:"#010101"
            pColor: "white"
        }

        ListElement {
            text:"Brown"
            kColor:"#693f27"
            tColor:"#fbfcfe"
            atColor:"#fbfcfe"
            atColor0:"white"
            atColor1:"white"
            atColor2:"#f4ff0f"
            atColor3:"white"
            hColor:"#a07b5e"
            bColor:"#010101"
            pColor: "white"
        }
        ListElement {
            text:"White"
            kColor:"#f9f9f9"
            tColor:"grey"
            atColor:"grey"
            atColor0:"grey"
            atColor1:"grey"
            atColor2:"red"
            atColor3:"grey"
            hColor:"white"
            bColor:"#bbb7b6"
            pColor: "grey"
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
                    id: transUp
                    leVis4: true
                    keyText: "O"

                    MouseArea {
                        id: ma8
                        anchors.fill: parent

                        onEntered: {
                            transUp.btnHovered()
                        }

                        onExited: {
                            transUp.btnHovered()
                        }

                        onPressed: {
                            transUp.btnPressed()
                        }

                        onPressAndHold: {
                            transUp.btnHold()
                        }

                        onReleased: {
                            transUp.btnReleased()
                        }

                        onClicked: {
                            transUp.btnClicked()
                            if (main.transparency<1) {
                                main.transparency+=0.1
                                settings.opacity = main.transparency

                            }

                            settings.setAndSaveConf()
                        }
                    }
                }

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
                            colorKey.btnHold()
                        }

                        onReleased: {
                            colorKey.btnReleased()
                        }

                        onClicked: {

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
                        }

                        onClicked: {
                            layoutKey.btnClicked()
                            if (main.layout == "Full") {
                                main.layout = "Tablet"
                            }
                            else {
                                main.layout = "Full"
                            }
                            main.symbolMode = false
                            settings.setLayout()
                        }
                    }
                }
            }

            Row{
                id: r2
                spacing: main.spacing

                Key{
                    id: transDown
                    leVis4: true
                    keyText: "o"

                    MouseArea {
                        id: ma7
                        anchors.fill: parent

                        onEntered: {
                            transDown.btnHovered()
                        }

                        onExited: {
                            transDown.btnHovered()
                        }

                        onPressed: {
                            transDown.btnPressed()
                        }

                        onPressAndHold: {
                            transDown.btnHold()
                        }

                        onReleased: {
                            transDown.btnReleased()
                        }

                        onClicked: {
                            transDown.btnClicked()
                            if (main.transparency>0.4) {
                                main.transparency-=0.1
                                settings.opacity = main.transparency
                            }

                            settings.setAndSaveConf()
                        }
                    }
                }

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
                            scaleDown.btnReleased()
                        }

                        onClicked: {
                            scaleDown.btnClicked()
                            if (main.scale>0.5) {
                                main.scale-=0.1
                            }

                            settings.setAndSaveConf()
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
                            scaleUp.btnReleased()
                        }

                        onClicked: {
                            scaleDown.btnClicked()
                            if (main.scale<1.5) {
                                main.scale+=0.1
                            }

                            settings.setAndSaveConf()
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

                        }

                        onPressAndHold: {
                            autoShowKey.btnHold()
                        }

                        onReleased: {
                            autoShowKey.btnReleased()
                        }

                        onClicked: {
                            autoShowKey.btnClicked()
                            main.autoShowToggle = !main.autoShowToggle
                            settings.setAndSaveConf()
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
        if (languageKey.keyText.substring(0,2) == "tr") {
            settings.colorsCurrentArr = settings.colorsTr
        } else if (languageKey.keyText.substring(0,3) == "ara") {
            settings.colorsCurrentArr = settings.colorsAra
        } else {
            settings.colorsCurrentArr = settings.colorsUs
        }
    }

    onColorsCurrentArrChanged : {
        colorKey.keyText = settings.colorsCurrentArr[settings.colorIndex]
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
        settings.colorIndex = main.themeName
        if (languageKey.keyText.substring(0,2) == "tr") {
            settings.colorsCurrentArr = settings.colorsTr
        } else if (languageKey.keyText.substring(0,3) == "ara") {
            settings.colorsCurrentArr = settings.colorsAra
        } else {
            settings.colorsCurrentArr = settings.colorsUs
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
