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
import QtQuick 2.3
import QtQuick.Controls 1.2
import eta.helper 1.0
import QtQuick.Window 2.0


ApplicationWindow {
    id: test
    visible: true
    x:screenWidth/2 - test.width/2
    y:screenHeight/2
    width: 400
    height: m_height
    title: qsTr("testQml")
    color:"#010101"
    flags: Qt.WindowStaysOnTopHint |
           Qt.FramelessWindowHint |
           Qt.WindowSystemMenuHint |
           Qt.WindowDoesNotAcceptFocus |
           Qt.X11BypassWindowManagerHint

    property int screenWidth: Screen.width
    property int screenHeight: Screen.height
    property int m_height: body.height
    property int layoutIndex : 0 // TRQ
    property string currentLayoutName
    property int keyLevel : 0
    property bool levelChanged : false

    property string keyColor: "#585858"
    property string keyPressedColor: "#ffffff"
    property string keyHoverColor: "#848484"
    property string textColor: "#dddddd"
    property string textPressedColor: "#5e5a5a"


    NumberAnimation {
        id:showFromBottom
        target:test
        property: "y"
        from:screenHeight-test.height
        to : screenHeight/2
        easing.overshoot: 2
        duration: 400
        easing.type: Easing.OutBack
        onStarted: {
            test.height = m_height
        }

    }

    ParallelAnimation {
        id: hide
        NumberAnimation {
            target: test
            property: "height"
            from: test.height
            to : test.height-m_height
            duration: 100
            easing.type: Easing.Linear

        }
        NumberAnimation {
            target: test
            property: "y"
            from: test.y
            to : test.y+screenHeight/2
            duration: 315
            easing.type: Easing.Linear

        }
    }


    Helper {
        id:helper
        onLayoutChanged: {            
            test.currentLayoutName = helper.getCurrentLayout()
            for(var i = 0; i< helper.getNumberOfLayouts();i++)
            {
                if ( test.currentLayoutName == comboModel.get(i).text) {
                    languages.currentIndex = i;
                    languages.update()
                }
            }
            console.log(helper.getCurrentLayout());
        }
        onShowFromBottomCalled: {
            console.log("showFroomBottomCalled from dbus");
            showFromBottom.start();
        }
        onShowFromLeftCalled: {
            console.log("showFromLeftCalled from dbus");
        }
        onHideCalled: {
            hide.start();
        }

    }
    function fakeKey(code){
        if (levelChanged) {
            switch(test.keyLevel){
            case 1:
                helper.fakeKeyPress(shift.keycode);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(shift.keycode);
                break
            case 2:
                helper.fakeKeyPress(altgr.keycode);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(altgr.keycode);
                break
            case 3:
                helper.fakeKeyPress(altgr.keycode);
                helper.fakeKeyPress(shift.keycode);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(shift.keycode);
                helper.fakeKeyRelease(altgr.keycode);
                break
            }
        } else {

            helper.fakeKeyPress(code);
            helper.fakeKeyRelease(code);

        }
    }


    Column {
        id:body
        Row {
            id:dock
            Rectangle {
                height: row1.height
                width: test.width - closeButton.width
                color : "gray"

                MouseArea{
                    anchors.fill: parent
                    property variant cpos: "1,1"
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    onPressed: {
                        cpos = Qt.point(mouse.x,mouse.y);
                    }
                    onPositionChanged: {
                        var delta =
                                Qt.point(mouse.x - cpos.x, mouse.y - cpos.y);
                        test.x += delta.x;
                        test.y += delta.y;
                    }
                }
            }
            Button {
                id:closeButton
                height: dock.height
                visible: true
                iconSource: "Images/window-close.png"
                onClicked: {
                    Qt.quit();
                }
            }
        }

        Row {
            id:row1
            Button {
                id : shift
                checkable: true
                property int keycode : 50
                text:"Shift"
                onCheckedChanged: {
                    if(shift.checked) {
                        test.keyLevel +=1;
                        test.levelChanged = true;
                    } else {

                        test.keyLevel -=1;
                        test.levelChanged = test.keyLevel!=0 ? true :false;
                    }
                }
            }
            Button {
                id:numericKey
                property int keycode : 13
                property int level : test.keyLevel
                text :helper.getSymbol(numericKey.keycode,
                                       test.layoutIndex,numericKey.level)
                onClicked: {
                    fakeKey(numericKey.keycode)
                }
            }

            Button {
                id:alphaKey
                property int keycode : 34
                property int level : test.keyLevel
                text : helper.getSymbol(alphaKey.keycode,
                                        test.layoutIndex,alphaKey.level)
                onClicked: {
                    fakeKey(alphaKey.keycode)
                }
            }

            Rectangle {
                id:newKey
                property int keycode : 35
                property int level: test.keyLevel
                height: alphaKey.height
                width: alphaKey.width
                color : ma.containsMouse ? "light green" : "green"
                Text{
                    anchors.centerIn: parent
                    text: helper.getSymbol(newKey.keycode,
                                           test.layoutIndex,newKey.level)
                }
                MouseArea {
                    id:ma
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {
                        newKey.color= "white";
                        helper.fakeKeyPress(newKey.keycode);
                    }
                    onReleased: {
                        newKey.color= ma.containsMouse ?
                                    "light green" : "green";
                        helper.fakeKeyRelease(newKey.keycode);
                    }
                    onHoveredChanged: newKey.color= ma.containsMouse ?
                                          "light green" : "green"
                }
            }
        }
        Row {
            id:row2
            Button {
                id :caps
                checkable: true
                property int keycode : 66
                text : "Caps_Lock"
                checked: helper.getCapslockStatus()
                onClicked: {
                    helper.fakeKeyPress(caps.keycode);
                    helper.fakeKeyRelease(caps.keycode);

                }


            }
            Button {
                id : altgr
                checkable: true
                property int keycode : 108
                text:"Alt_Gr"

                onCheckedChanged: {

                    if(altgr.checked) {
                        test.keyLevel +=2;
                        test.levelChanged = true;
                    } else {
                        test.keyLevel -=2;
                        test.levelChanged = test.keyLevel!=0 ? true :false;
                    }
                }
            }
        }
        Row {
            id:row3
            Button {
                id :space
                width: row2.width
                property int keycode : 65
                property int level : test.keyLevel
                text :helper.getSymbol(space.keycode,
                                       test.layoutIndex,space.level)
                onClicked: {
                    fakeKey(space.keycode)
                }
            }
            ListModel {
                id:comboModel

            }

            ComboBox{
                id:languages
                editable: false
                model: comboModel
                onCurrentIndexChanged: {
                    test.layoutIndex = currentIndex;
                    helper.setLayout(currentIndex);
                    test.currentLayoutName = comboModel.get(currentIndex).text;
                }

            }

        }
    }
    Timer {
        running: true
        repeat: true
        interval: 5
        onTriggered: {
            caps.checked = helper.getCapslockStatus();
        }
    }
    Component.onCompleted: {
        console.log("Number of layouts = "+helper.getNumberOfLayouts());
        for(var i = 0; i< helper.getNumberOfLayouts();i++)
        {
            comboModel.append({text:helper.getLayoutName(i)});
            if(helper.getLayoutName(i) == helper.getCurrentLayout()) {
                test.layoutIndex = i;
            }
        }
        test.currentLayoutName = helper.getCurrentLayout();
        languages.currentIndex = test.layoutIndex;
    }

}
