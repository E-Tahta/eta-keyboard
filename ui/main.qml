import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0


ApplicationWindow {
    id: main
    visible: false
    title: qsTr("ETA Virtual Keyboard")
    color: "#010101"

    flags:Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowDoesNotAcceptFocus | Qt.X11BypassWindowManagerHint


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
    property string layout: "tablet"
    property int languageLayoutIndex: 0 // Current System Language Layout
    property int keyLevel: 0
    property bool releaseAll: false
    property bool settingsVisible : false
    property bool updateTheme: false
    property bool keyHover: true
    property bool password: false

    ListModel {
        id:stickyModel
    }


    Helper {
        id: helper
    }

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


    function nonStickyPressed(keyCode){

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
    }


    function nonStickyReleased(keyCode){

        if (!checkAlt()){
            helper.fakeKeyRelease(keyCode)

            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyRelease(stickyModel.get(i).keyCode)
            }

            main.releaseAll = !main.releaseAll;

            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyRelease(stickyModel.get(i).keyCode)
                console.log(stickyModel.get(i).keyCode+" if you see me there is a problem")
            }
        }
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

                            console.log(main.password)
                        }
                        else {
                            passwordToggle.color = pToggleMa.containsMouse ? main.keyHoverColor : main.keyColor
                            pToggleText.color = main.textColor
                            main.password = false

                            console.log(main.password)
                        }
                    }

                }

            }


            Image {
                id: closeBtnImage
                source: "Images/window-close.png"

                anchors.right: dock.right
                anchors.top: dock.top
                anchors.bottom: dock.bottom
                height:main.dockSize
                width: closeBtnImage.height
                MouseArea{
                    anchors.fill: closeBtnImage
                    onClicked: Qt.quit()
                }
            }


            MouseArea{
                anchors{
                    top: dock.top
                    left: passwordToggle.right
                    bottom: dock.bottom
                    right:closeBtnImage.left
                }
                property variant cpos: "1,1"
                onPressed: {
                    cpos = Qt.point(mouse.x,mouse.y);
                    // main.opacity = 0.3
                    //settings.opacity = 0.3
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x - cpos.x, mouse.y - cpos.y);
                    main.x += delta.x;
                    main.y += delta.y;

                }
                onReleased: {
                    // main.opacity = 1
                    //settings.opacity = settingsVisible ? 0 : 1
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

    function setSize(){
        var tX = main.width
        var tY = main.height




        main.keyHeight = Screen.height * main.scale / 23
        main.dockSize = Screen.height * main.scale / 35


        if (main.layout == "full"){
            main.width = main.keyHeight * 15 + main.spacing * 16
            main.height = main.keyHeight * 11 / 2 + main.dockSize + main.spacing * 8
        }
        else {
            main.width = main.keyHeight * 11 + main.spacing * 12
            main.height = main.keyHeight * 4  + main.dockSize + main.spacing * 6
        }

        tX -= main.width
        tY -= main.height

        main.x += tX / 2
        main.y += tY / 2

    }



    Component.onCompleted: {


        main.keyHeight = Screen.height * main.scale / 23
        main.dockSize = Screen.height * main.scale / 35

        setSize()

        main.x = Screen.width / 2 - main.width / 2
        main.y = Screen.height - main.height

        main.visible = true
    }


    onLayoutChanged: {

        setSize()

    }

    onScaleChanged: {

        setSize()

    }

}
