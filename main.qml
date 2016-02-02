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
    property int languageLayoutIndex: 0 // Current System Language Layout
    property int keyLevel: 0
    property int stickyNum: 0
    property bool releaseAll: false



    Helper {
        id: helper
    }



    function stickyKeyPressed(keyCode){
        main.stickyNum++
        switch(keyCode){
        case 50: main.keyLevel+=1;break;        //Shift
        case 108: main.keyLevel+=2;break;        //Alt Gr
        case 66 : main.stickyNum--
        }

        if (main.stickyNum>3) main.releaseAll=!main.releaseAll


        console.log(keyLevel+" "+main.stickyNum)
    }

    function stickyKeyReleased(keyCode){
        main.stickyNum--
        switch(keyCode){
        case 50: main.keyLevel-=1;break;        //Shift
        case 108: main.keyLevel-=2;break;       //Alt Gr
        case 66: main.stickyNum++;
        }
        console.log(keyLevel+" "+main.stickyNum)
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

