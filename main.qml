import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0


ApplicationWindow {
    id: main
    visible: true
    title: qsTr("ETA Virtual Keyboard")
    color: "#010101"


    flags:Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowDoesNotAcceptFocus


    property string keyColor: settings.keyColor//"#585858"
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
    property int languageLayoutIndex: 0 // Current System Language Layout
    property int keyLevel: 0
    property int stickyNum: 0
    property bool releaseAll: false


    property bool settingsVisible : false

    property bool updateTheme: false

    Settings{

        id: settings

    }


    ListModel {
        id:stickyModel

    }


    Helper {
        id: helper

    }

    function stickyKeyPressed(keyCode){

        var press = true

        if (main.stickyNum<3){
            main.stickyNum++

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

        if (main.stickyNum>0){

            main.stickyNum--

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
            main.releaseAll = ! main.releaseAll;

        }

        else {
            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyPress(stickyModel.get(i).keyCode)
                console.log(stickyModel.get(i).keyCode+" in")
            }

            helper.fakeKeyPress(keyCode)
        }



    }


    function nonStickyReleased(keyCode){

        if (!checkAlt()){
            helper.fakeKeyRelease(keyCode)

            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyRelease(stickyModel.get(i).keyCode)
                console.log(stickyModel.get(i).keyCode+" out")
            }

            main.releaseAll = ! main.releaseAll;

            for (var i=0; i<stickyModel.count; i++){
                helper.fakeKeyRelease(stickyModel.get(i).keyCode)
                console.log(stickyModel.get(i).keyCode+" if you see me there is a problem")
            }
        }


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
        main.keyHeight = Screen.height / 18
        main.dockSize = Screen.height / 30
        main.width = main.keyHeight * 15 + 15 * main.rowSpacing
        main.height = main.keyHeight * 11 / 2 + main.dockSize + 7 * main.columnSpacing
    }

}

