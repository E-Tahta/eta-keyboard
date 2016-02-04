import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0


ApplicationWindow {
    id: main
    visible: true
    title: qsTr("Hello World")
    color: "#010101"

    flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowDoesNotAcceptFocus

    property string keyColor: "#585858"
    property string keyPressedColor: "#ffffff"
    property string keyHoverColor: "#848484"
    property string textColor: "#dddddd"
    property string activeTextColor: "white"
    property string textPressedColor: "#5e5a5a"
    property int keyHeight
    property int keyWidth: keyHeight
    property int rowSpacing: keyHeight / 10
    property int columnSpacing: rowSpacing

    property int dockSize

    property string layout: "full"
    property int languageLayoutIndex: 2 // Current System Language Layout
    property int keyLevel: 0
    property int stickyNum: 0
    property bool releaseAll: false
    property variant stickyKeyList: []




    Helper {
        id: helper
    }



    function stickyKeyPressed(keyCode){

        var t = new Array (0)

        main.stickyNum++
        if (main.stickyNum<4){

            switch(keyCode){
            case 50: //shift
                keyLevel++;
                t.push(keyCode)
                break;
            case 37: //ctrlL
                t.push(keyCode)
                break;
            case 133: //meta
                t.push(keyCode)
                break;
            case 64: //alt
                t.push(keyCode)
                break;
            case 108: //AltGr
                main.keyLevel+=2;
                t.push(keyCode)
                break;
            case 105: //AltGr
                t.push(keyCode)
                break;
            }

            main.stickyKeyList = t
        }
        else {
            main.releaseAll = ! main.releaseAll;

            t = new Array(0)
            main.stickyKeyList = t

        }
    }

    function stickyKeyReleased(keyCode){

        main.stickyNum--

        switch(keyCode){
        case 50: //shift
            keyLevel--;
            helper.fakeKeyRelease(keyCode);
            break;
        case 37: //ctrlL
            helper.fakeKeyRelease(keyCode);
            break;
        case 133: //meta
            helper.fakeKeyRelease(keyCode);
            break;
        case 64: //alt
            helper.fakeKeyRelease(keyCode);
            break;
        case 108: //AltGr
            main.keyLevel-=2;
            helper.fakeKeyRelease(keyCode);
            break;
        case 105: //AltGr
            helper.fakeKeyRelease(keyCode);
            break;
        }
    }


    function nonStickyPressed(keyCode){

        main.releaseAll=!main.releaseAll

    }



    FullLayout{
        id: fullLay
        visible: main.layout=="full" ? true : false

    }

    TabletLayout{
        id: tabletLayout

        visible: main.layout=="tablet" ? true : false
    }


    Component.onCompleted: {
        main.dockSize = Screen.height / 30 //check if tablet or full then give different
        main.keyHeight = Screen.height / 16
        main.width = main.keyHeight * 16.2 + 2
        main.height = main.keyHeight * 6 + main.dockSize + main.columnSpacing
    }

}

