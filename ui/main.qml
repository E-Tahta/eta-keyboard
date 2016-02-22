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
    flags:Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowDoesNotAcceptFocus | Qt.X11BypassWindowManagerHint
    id: main
    visible: false
    title: qsTr("ETA Virtual Keyboard")
    color: "#010101"

    property string keyColor: "#585858" //settings.keyColor
    property string keyPressedColor: "#ffffff"
    property string keyHoverColor: "#848484"
    property string textColor: "#dddddd"
    property string activeTextColor: "white"
    property string textPressedColor: "#5e5a5a"
    property int keyHeight
    property int keyWidth: keyHeight
    property int spacing: keyHeight / 12
    property int dockSize
    property double scale : 1 // 0.2 ... 1.8
    property string layout: "full"
    property int languageLayoutIndex: 0 // Current System Language Layout
    property int keyLevel: 0
    property bool releaseAll: false
    property bool settingsVisible
    property bool updateTheme: false
    property bool keyHover: true
    property bool password: false
    property string storedMirror
    property int screenWidth: Screen.width
    property int screenHeight: Screen.height
    property int m_height
    property int m_width
    property int m_settings_height
    property int m_settings_width
    property bool keyboardVisible: false
    property bool autoShowToggle
    property bool layoutChange: false

    function stickyKeyPressed(keyCode){
        var press = true
        if (stickyModel.count<3){
            switch(keyCode){
            case 50: //shift
                keyLevel++;
                break;
            case 108: //AltGr
                main.keyLevel+=2;
                break;
            }
            for (var i=0; i<stickyModel.count; i++)
                if(stickyModel.get(i).keyCode == keyCode)
                    press = false
            if (press)
                stickyModel.append({keyCode:keyCode})
        }
        else {
            main.releaseAll = ! main.releaseAll;
        }
    }

    function stickyKeyReleased(keyCode){
        if (stickyModel.count>0){
            for (var i=0; i<stickyModel.count; i++){
                if (stickyModel.get(i).keyCode == keyCode)
                    stickyModel.remove(i)
            }
            switch(keyCode){
            case 50: //shift
                keyLevel--;
                break;
            case 108: //AltGr
                main.keyLevel-=2;
                break;
            }
        }
    }

    function checkAlt(){
        return stickyModel.count === 1 && stickyModel.get(0).keyCode === 64;
    }

    function checkShiftAltgr(){
        if (stickyModel.count == 0) return true
        else if (stickyModel.count == 1)
            return stickyModel.get(0).keyCode === 50 || stickyModel.get(0).keyCode === 108
        else if (stickyModel.count == 2){
            var cnt = 0
            if(stickyModel.get(0).keyCode === 50 || stickyModel.get(0).keyCode === 108) cnt ++
            if(stickyModel.get(1).keyCode === 50 || stickyModel.get(1).keyCode === 108) cnt ++
            if (cnt == 2) return true
            else return false
        }
        return false
    }

    function nonStickyPressed(keyCode,mirror){
        if (checkAlt()){
            helper.fakeKeyPress(64)
            helper.fakeKeyPress(keyCode)
            helper.fakeKeyRelease(keyCode)
            helper.fakeKeyRelease(64)
            main.releaseAll = !main.releaseAll;
        }
        else {
            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyPress(stickyModel.get(i).keyCode)
            }
            helper.fakeKeyPress(keyCode)
        }
        if (mirror && checkShiftAltgr()){
            main.storedMirror += helper.getSymbol(keyCode,main.languageLayoutIndex,main.keyLevel)
            if (main.password)
                mirrorText.text +="*"
            else
                mirrorText.text += helper.getSymbol(keyCode,main.languageLayoutIndex,main.keyLevel)
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
        case 22:
            mirrorText.text = mirrorText.text.substring(0, mirrorText.text.length - 1)
            main.storedMirror = main.storedMirror.substring(0, main.storedMirror.length - 1)
        }
    }

    function nonStickyReleased(keyCode){
        if (!checkAlt()){
            helper.fakeKeyRelease(keyCode)
            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyRelease(stickyModel.get(i).keyCode)
            }
            //main.releaseAll = !main.releaseAll;
            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyRelease(stickyModel.get(i).keyCode)
                console.log(stickyModel.get(i).keyCode+" if you see me there is a problem")
            }
        }
    }

    function setSize(){
        var oldWidth = main.width
        var oldHeight = main.height
        main.keyHeight =  main.screenHeight * main.scale / 23
        main.dockSize = main.screenHeight * main.scale / 35
        if (main.layout == "full"){
            main.width = main.keyHeight * 15 + main.spacing * 16
            main.height = main.keyHeight * 11 / 2 + main.dockSize + main.spacing * 8
        }
        else {
            main.width = main.keyHeight * 11 + main.spacing * 12
            main.height = main.keyHeight * 4  + main.dockSize + main.spacing * 6
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
                color: pToggleMa.containsMouse ? main.keyHoverColor : main.keyColor
                radius: passwordToggle.height / 2
                anchors{
                    left: dock.left
                    top: dock.top
                }

                Text {
                    id: pToggleText
                    text: qsTr("P")
                    color: main.textColor
                    anchors.centerIn: parent
                }

                MouseArea{
                    id: pToggleMa
                    anchors.fill: parent
                    hoverEnabled: main.keyHover

                    onPressed: {
                        if (!main.password){
                            passwordToggle.color = main.keyPressedColor
                            pToggleText.color = main.textPressedColor
                            main.password = true
                        }
                        else {
                            passwordToggle.color = pToggleMa.containsMouse ? main.keyHoverColor : main.keyColor
                            pToggleText.color = main.textColor
                            main.password = false
                        }
                    }
                }
            }//End of passwordToggle

            Image {
                id: closeBtnImage
                source: "Images/window-close.png"
                height:main.dockSize
                width: closeBtnImage.height
                anchors {
                    right: dock.right
                    top: dock.top
                    bottom: dock.bottom
                }

                MouseArea{
                    anchors.fill: closeBtnImage

                    onClicked: {
                        hide.start();
                    }
                }
            }

            Text {
                id: mirrorText
                text: ""
                font.pointSize: main.dockSize ? main.dockSize / 2 : 15
                color: main.activeTextColor
                anchors.centerIn: dock
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
            visible: main.layout=="full" ? true : false
            anchors.top: dock.bottom
        }

        TabletLayout{
            id: tabletLayout
            visible: main.layout=="tablet" ? true : false
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
        to : main.screenHeight - main.m_height * 3 / 2
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
            main.y = main.screenHeight - main.m_height * 3 / 2
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
            main.y = main.screenHeight - main.m_height * 3 / 2
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
            main.releaseAll = !main.releaseAll
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
    }

    Component.onCompleted: {
        hide.start()
        main.screenHeight = Screen.height
        main.screenWidth = Screen.width
        setSize()
        main.x =  main.screenWidth / 2 - main.width /2
        main.y = main.screenHeight + main.height
        main.settingsVisible = false
        main.autoShowToggle = helper.getAutoShow()
        console.log(main.autoShowToggle)
    }
}

