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
    flags:Qt.WindowStaysOnTopHint |
          Qt.FramelessWindowHint |
          Qt.WindowSystemMenuHint |
          Qt.WindowDoesNotAcceptFocus |
          Qt.X11BypassWindowManagerHint
    id: main
    visible: false
    title: qsTr("ETA Virtual Keyboard")
    color: "#010101"

    property string keyColor: "#585858" //settings.keyColor
    property string keyPressedColor: "#ffffff"
    property string keyHoverColor: "#848484"
    property string textColor: "#dddddd"
    property string activeTextColor: "white"
    property string activeTextColor0: "white"
    property string activeTextColor1: "white"
    property string activeTextColor2: "white"
    property string activeTextColor3: "white"
    property string textPressedColor: "#5e5a5a"
    property int keyHeight
    property int keyWidth: keyHeight
    property int spacing: keyHeight / 12
    property int dockSize
    property double scale: 1 // 0.2 ... 1.8
    property string layout
    property int languageLayoutIndex: 0 // Current System Language Layout
    property int keyLevel: 0
    property bool symbolMode: false
    property bool releaseAll: false
    property bool settingsVisible
    property bool updateTheme: false
    property bool keyHover: true
    property bool keyHoverTimer: false
    property bool keyHoverTimerTriggered: false
    property bool password: false
    property int screenWidth: Screen.width
    property int screenHeight: Screen.height
    property int m_height
    property int m_width
    property int m_settings_height
    property int m_settings_width
    property bool keyboardVisible: false
    property bool autoShowToggle
    property bool layoutChange: false
    property string themeName
    property bool loaded: false
    property string storedMirror
    property string mirrorCharacter
    property bool btnCtrl: false
    property bool btnAlt: false
    property bool btnMeta: false
    property bool btnShift: false
    property bool btnAltGr: false
    property bool sticky: false
    property int stickyNum: 0

    function setAndSave(){
        helper.setSettings(main.themeName,
                           main.layout,
                           main.scale,
                           main.languageLayoutIndex,
                           main.autoShowToggle)
        helper.saveSettings()
    }

    function releaseAllSticky(){
        btnAlt = false
        btnAltGr = false
        btnCtrl = false
        btnMeta = false
        btnShift = false
        sticky = false
        stickyNum = 0
        keyLevel = 0
        releaseAll = !releaseAll
    }


    function keyClicked(keyCode,mirror,keyText,level,code){

        main.settingsVisible = false

        if (symbolMode && mirror) {
            switch(level) {
            case 0:
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                break;
            case 1:
                helper.fakeKeyPress(50);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(50);
                break
            case 2:
                helper.fakeKeyPress(108);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(108);
                break
            case 3:
                helper.fakeKeyPress(108);
                helper.fakeKeyPress(50);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(50);
                helper.fakeKeyRelease(108);
                break
            }

            main.storedMirror += keyText
            if (main.password) {
                mirrorText.text +="*"
            }
            else {
                mirrorText.text += keyText
            }
            if (keyCode == 65) {
                mirrorText.text = ""
                main.storedMirror = ""
            }

        }
        else {
            switch (keyCode){
            case 500: // symbol
                symbolMode = !symbolMode
                sticky = true
                break
            case 37: // ctrlL
                stickyNum+= btnCtrl ? -1 : 1
                btnCtrl = !btnCtrl
                sticky = true
                break
            case 64: // alt
                stickyNum+= btnAlt ? -1 : 1
                btnAlt = !btnAlt
                sticky = true
                break
            case 133: // meta
                stickyNum+= btnMeta ? -1 : 1
                btnMeta = !btnMeta
                sticky = true
                break
            case 108: // altgr
                stickyNum+= btnAltGr ? -1 : 1
                main.keyLevel+= btnAltGr ? -2 : 2
                btnAltGr = !btnAltGr
                sticky = true
                break
            case 50: // shift
                stickyNum+= btnShift ? -1 : 1
                main.keyLevel+= btnShift ? -1 : 1
                btnShift = !btnShift
                sticky = true
                break
            }

            if (stickyNum>3){
                releaseAllSticky()
                return 0
            }

            if (!sticky) {

                if (btnAlt){
                    helper.fakeKeyPress(64)
                }

                if (btnAltGr){
                    helper.fakeKeyPress(108)
                }

                if (btnCtrl){
                    helper.fakeKeyPress(37)
                }

                if (btnMeta){
                    helper.fakeKeyPress(133)
                }

                if (btnShift){
                    helper.fakeKeyPress(50)
                }

                helper.fakeKeyPress(keyCode);
                helper.fakeKeyRelease(keyCode);

                if (mirror && !btnAlt && !btnCtrl && !btnMeta){

                    if (helper.getCapslockStatus() &&
                            main.keyLevel == 0) {


                        mirrorCharacter = helper.getSymbol(keyCode,
                                                           main.languageLayoutIndex,
                                                           main.keyLevel)

                        main.storedMirror += mirrorCharacter.toUpperCase()
                        if (main.password) {
                            mirrorText.text +="*"
                        }
                        else {
                            mirrorText.text += mirrorCharacter.toUpperCase()
                        }
                    } else if (helper.getCapslockStatus() &&
                               main.keyLevel == 1 ){

                        mirrorCharacter = helper.getSymbol(keyCode,
                                                           main.languageLayoutIndex,
                                                           main.keyLevel)

                        main.storedMirror += mirrorCharacter.toLowerCase()
                        if (main.password)
                            mirrorText.text +="*"
                        else
                            mirrorText.text += mirrorCharacter.toLowerCase()
                    } else {
                        mirrorCharacter = helper.getSymbol(keyCode,
                                                           main.languageLayoutIndex,
                                                           main.keyLevel)

                        main.storedMirror += mirrorCharacter
                        if (main.password) {
                            mirrorText.text +="*"
                        }
                        else {
                            mirrorText.text += mirrorCharacter
                        }
                    }

                }
                switch (keyCode){
                case 65:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;
                case 36:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;
                case 111:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;
                case 113:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;
                case 114:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;
                case 116:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;
                case 23:
                    mirrorText.text = ""
                    main.storedMirror = ""
                    break;

                }

                if (btnAlt){
                    helper.fakeKeyRelease(64)
                }

                if (btnAltGr){
                    helper.fakeKeyRelease(108)
                }

                if (btnCtrl){
                    helper.fakeKeyRelease(37)
                }

                if (btnMeta){
                    helper.fakeKeyRelease(133)
                }

                if (btnShift){
                    helper.fakeKeyRelease(50)
                }

                releaseAllSticky()
            }

            sticky = false
        }
    }


    function fakeKeyTablet(code,level,keyText) {
        main.settingsVisible = false
        switch(level) {
        case 0:
            helper.fakeKeyPress(code);
            helper.fakeKeyRelease(code);
            break;
        case 1:
            helper.fakeKeyPress(50);
            helper.fakeKeyPress(code);
            helper.fakeKeyRelease(code);
            helper.fakeKeyRelease(50);
            break
        case 2:
            helper.fakeKeyPress(108);
            helper.fakeKeyPress(code);
            helper.fakeKeyRelease(code);
            helper.fakeKeyRelease(108);
            break
        case 3:
            helper.fakeKeyPress(108);
            helper.fakeKeyPress(50);
            helper.fakeKeyPress(code);
            helper.fakeKeyRelease(code);
            helper.fakeKeyRelease(50);
            helper.fakeKeyRelease(108);
            break
        }

        main.storedMirror += keyText
        if (main.password)
            mirrorText.text +="*"
        else
            mirrorText.text += keyText
    }


    function setSize(){
        var oldWidth = main.width
        var oldHeight = main.height
        var scaleVariable

        if (main.layout == "Full") {
            scaleVariable = main.scale
        } else {
            scaleVariable = main.scale + 0.2
        }

        main.keyHeight =  main.screenHeight * scaleVariable / 23
        main.dockSize = main.screenHeight * scaleVariable / 35
        if (main.layout == "Full"){
            main.width = main.keyHeight * 15 + main.spacing * 16
            main.height = main.keyHeight * 11 / 2 + main.dockSize +
                    main.spacing * 8
        }
        else {
            main.width = main.keyHeight * 12 + main.spacing * 13
            main.height = main.keyHeight * 4  + main.dockSize +
                    main.spacing * 6
        }
        settings.width =  main.keyWidth * 3 + main.spacing * 5
        settings.height = main.keyHeight * 2 + main.spacing * 3
        main.m_height = main.height
        main.m_width = main.width
        main.m_settings_height = settings.height
        main.m_settings_width = settings.width
        main.x += (oldWidth - main.width) / 2
        main.y += (oldHeight - main.height) / 2
        main.visible = true
    }

    function pressedBackspace(){
        helper.fakeKeyPress(22)
        mirrorText.text =
                mirrorText.text.substring(0, mirrorText.text.length - 1)
        main.storedMirror =
                main.storedMirror.substring(0, main.storedMirror.length - 1)
    }

    function releasedBackspace(){
        helper.fakeKeyRelease(22)
    }

    function holdBackspace(keyCode){
        if (keyCode == 22){
            mirrorText.text = ""
            main.storedMirror = ""
        }
    }

    Helper {
        id: helper

        onShowFromBottomCalled: {
            if (!keyboardVisible && autoShowToggle){
                showFromBottom.start();
            }
        }

        onShowFromLeftCalled: {
            if (!keyboardVisible && autoShowToggle){
                showFromLeft.start();
            }
        }

        onShowFromRightCalled: {
            if (!keyboardVisible && autoShowToggle){
                showFromRight.start();
            }
        }

        onHideCalled: {
            if (keyboardVisible && autoShowToggle){
                hide.start();
            }
        }

        onToggleCalled: {
            if (keyboardVisible) {
                hide.start()
            }
            else {
                showFromBottom.start()
            }
        }

        onToggleAutoShowCalled: {
            main.autoShowToggle = !main.autoShowToggle
        }

        onLayoutChanged: {
            main.layoutChange = !main.layoutChange
        }
    }

    ListModel {
        id:stickyModel
    }

    Item {
        id: container

        Rectangle {
            id: dock
            height: main.dockSize
            width: main.width
            color: main.color
            anchors{
                top: container.top
                left: container.left
                margins: main.spacing
            }

            Rectangle {
                id: passwordToggle
                height: dock.height
                width: passwordToggle.height
                color:  main.keyColor
                radius: passwordToggle.height / 2
                anchors{
                    left: dock.left
                    top: dock.top
                }
                z: +5

                Text {
                    id: pToggleText
                    text: qsTr("P")
                    color: main.textColor
                    anchors.centerIn: parent
                }

                MouseArea{
                    id: pToggleMa
                    anchors.fill: parent

                    onClicked: {
                        if (!main.password){

                            main.password = true
                            main.keyHover = false
                        }
                        else {

                            main.password = false
                            main.keyHover = true
                        }
                    }
                }
            }//End of passwordToggle

            Image {
                id: closeBtnImage
                source: "Images/close.svg"
                height:main.dockSize
                width: closeBtnImage.height
                anchors {
                    right: dock.right
                    top: dock.top
                    bottom: dock.bottom
                }
                z: +5

                MouseArea{
                    anchors.fill: closeBtnImage

                    onClicked: {
                        hide.start();
                    }
                }
            }

            Item {
                id: mirrorTextContainer
                anchors {
                    left: passwordToggle.right
                    right: closeBtnImage.left
                    top: dock.top
                    bottom: dock.bottom
                }

                Text {
                    id: mirrorText
                    text: ""
                    font.pointSize: main.dockSize ? main.dockSize / 2 : 15
                    color: main.activeTextColor
                    anchors.centerIn: mirrorTextContainer
                    wrapMode: Text.WordWrap
                    z: -5
                }
            }



            MouseArea{
                property variant cpos: "1,1"
                anchors{
                    top: dock.top
                    left: passwordToggle.right
                    bottom: dock.bottom
                    right:closeBtnImage.left
                }

                onPressed: {
                    cpos = Qt.point(mouse.x,mouse.y);
                }

                onPositionChanged: {
                    main.settingsVisible = false
                    var delta = Qt.point(mouse.x - cpos.x, mouse.y - cpos.y);
                    main.x += delta.x;
                    main.y += delta.y;
                }

                onReleased: {

                }
            }
        }

        FullLayout{
            id: fullLay
            visible: main.layout=="Full" ? true : false
            anchors.top: dock.bottom
        }

        TabletLayout{
            id: tabletLayout
            visible: main.layout=="Tablet" ? true : false
            anchors.top: dock.bottom
        }
    }

    Settings{
        id: settings
    }

    NumberAnimation {
        id:showFromBottom
        target:main
        property: "y"
        from: main.screenHeight + main.height
        to : main.screenHeight - main.m_height - main.spacing * 20
        duration: 400
        easing.type: Easing.OutBack

        onStarted: {
            main.visible = true
            main.keyboardVisible = true
            settings.height = main.m_settings_height
            main.opacity = 1
            settings.opacity = 1
            main.height = main.m_height
            main.width = main.m_width
            main.x = main.screenWidth / 2 - main.m_width / 2
        }
    }

    NumberAnimation {
        id:showFromLeft
        target:main
        property: "x"
        from: -main.width
        to : main.screenWidth / 2 - main.m_width /2
        duration: 400
        easing.type: Easing.OutBack

        onStarted: {
            settings.height = main.m_settings_height
            main.visible = true
            main.width = main.m_width
            main.height = main.m_height
            main.y = main.screenHeight - main.m_height - main.spacing * 20
            main.keyboardVisible = true
            main.opacity = 1
            settings.opacity = 1
        }
    }

    NumberAnimation {
        id:showFromRight
        target:main
        property: "x"
        from: main.screenWidth
        to : main.screenWidth / 2 - main.m_width /2
        duration: 400
        easing.type: Easing.OutBack

        onStarted: {
            settings.height = main.m_settings_height
            main.visible = true
            main.width = main.m_width
            main.height = main.m_height
            main.y = main.screenHeight - main.m_height - main.spacing * 20
            main.keyboardVisible = true
            main.opacity = 1
            settings.opacity = 1
        }
    }

    ParallelAnimation {
        id: hide

        NumberAnimation {
            target: main
            property: "height"
            from: main.height
            to : 0
            duration: 100
        }

        NumberAnimation {
            target: settings
            property: "height"
            from: settings.height
            to : 0
            duration: 100
        }

        NumberAnimation {
            target: main
            property: "y"
            from: main.y
            to : main.y + main.m_height / 2
            duration: 100
            easing.type: Easing.Linear
        }

        onStarted: {
            main.settingsVisible = false
            main.keyboardVisible = false
            mirrorText.text = ""
            main.storedMirror = ""
            releaseAllSticky()
        }

        onStopped: {
            main.visible = false
        }
    }

    onLayoutChanged: {
        setSize()
    }

    onScaleChanged: {
        setSize()
    }



    onPasswordChanged: {
        if (main.password){
            var len = mirrorText.text.length
            mirrorText.text = ""
            for (var i=0; i<len; i++){
                mirrorText.text += "*"
            }
        }
        else {
            mirrorText.text = main.storedMirror
        }

        passwordToggle.color = main.password ? main.keyPressedColor :
                                               main.keyColor
        pToggleText.color = main.password ? main.textPressedColor :
                                            main.textColor
    }


    onKeyHoverTimerChanged: {
        timer.start()
    }

    Component.onCompleted: {
        main.themeName = helper.getColor() ? helper.getColor() : "Grey"
        main.autoShowToggle = helper.getAutoShow() ?
                    helper.getAutoShow() : false
        main.layout = helper.getLayoutType() ? helper.getLayoutType() : "Tablet"
        main.scale = helper.getScale() < 1.6 && helper.getScale() > 0.4 ?
                    helper.getScale() : 1

        hide.start()
        main.screenHeight = Screen.height
        main.screenWidth = Screen.width
        setSize()
        main.x =  main.screenWidth / 2 - main.width /2
        main.y = main.screenHeight + main.height
        main.settingsVisible = false
        main.loaded = true

    }

    Timer {
        id: timer
        running: false
        interval: 1250
        onTriggered: {
            if (main.keyHoverTimer) {
                main.keyHoverTimer = false
                main.keyHoverTimerTriggered = !main.keyHoverTimerTriggered

            }
        }
    }
}

