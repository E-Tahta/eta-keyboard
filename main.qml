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

    property bool capsLock: false
    property bool shift: false
    property bool ctrlL: false
    property bool meta: false
    property bool alt: false
    property bool altGr: false
    property bool ctrlR: false



    Helper {
        id: helper
    }



    function stickyKeyPressed(keyCode){
        main.stickyNum++
        switch(keyCode){
        case 50: //Shift
            main.keyLevel+=1;
            main.shiftL = true;
            break;
        case 108: //Alt Gr
            main.keyLevel+=2;
            main.altGr = true;
            break;
        case 66 : //CapsLock
            main.stickyNum--;
            main.capsLock = true;
            break;
        case 37: //CtrlL
            main.ctrlL = true;
            break;
        case 133: //Meta
            main.meta = true;
            break;
        case 64: //Alt
            main.alt = true;
            break;
        case 105://CtrlR
            main.ctrlR = true;
            break;

        }

        if (main.stickyNum>3) main.releaseAll=!main.releaseAll



    }

    function stickyKeyReleased(keyCode){
        main.stickyNum--
        switch(keyCode){
        case 50: //Shift
            main.keyLevel-=1;
            main.shiftL = false;
            break;
        case 108: //Alt Gr
            main.keyLevel-=2;
            main.altGr = false;
            break;
        case 66 : //CapsLock
            main.stickyNum++;
            main.capsLock = false;
            break;
        case 37: //CtrlL
            main.ctrlL = false;
            break;
        case 133: //Meta
            main.meta = false;
            break;
        case 64: //Alt
            main.alt = false;
            break;
        case 105://CtrlR
            main.ctrlR = false;
            break;

        }
    }


    function nonStickyPressed(keyCode){



        console.log(keyCode+" "+keyLevel+" "+main.capsLock+" "+main.stickyNum)
        main.releaseAll=!main.releaseAll

    }

    Test{

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
        main.width = main.keyHeight * 16.4
        main.height = main.keyHeight * 6 + main.dockSize + main.columnSpacing
    }

}

