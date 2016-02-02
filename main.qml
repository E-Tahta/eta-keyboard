import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.0


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

    property int keyLevel: 0




    function stickyKeyPressed(keyCode){
        switch(keyCode){
        case "Shift": main.keyLevel+=1;break;
        case "Alt Gr": main.keyLevel+=2;
        }
        console.log(keyLevel)
    }

    function stickyKeyReleased(keyCode){
        switch(keyCode){
        case "Shift": main.keyLevel-=1;break;
        case "Alt Gr": main.keyLevel-=2;
        }
        console.log(keyLevel)
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


    /*
    property bool keyCapsPressed: false

    property int stickyNumber: 1
    property string stickyButtons



    function engine(btnCode){
        if (stickyNumber>3){
            releaseAll();
        }
        else {
            stickyButtons+=btnCode+" "
            stickyNumber++;
        }


    }

    function checkNumOfSticky(){

    }

    function releaseAll(){
        keyShiftL.releaseBtn()
        keyCtrlL.releaseBtn()
        keyCtrlR.releaseBtn()
        keyAlt.releaseBtn()
        keyAltGr.releaseBtn()
        stickyNumber= 1
        stickyButtons=""
    }

    function nonStickyPressed(btnCode){
        if (stickyNumber>1){
            stickyButtons+=btnCode
            console.log(stickyButtons)
            releaseAll()
        }

        else console.log(btnCode)
    }
*/



    /*

    Column{
        id: col1
        spacing: main.columnSpacing


        Rectangle {
            id: dock
            width: main.width
            color: main.color

            Button{
                id: closeBtn
                anchors.right: dock.right
                anchors.top: dock.top
                anchors.bottom: dock.bottom
                width: 40
                text: "Close"
                onClicked: Qt.quit()
            }

            MouseArea{
                anchors{
                    top: dock.top
                    left: dock.left
                    bottom: dock.bottom
                    right:closeBtn.left
                }
                property variant cpos: "1,1"
                onPressed: {
                    cpos = Qt.point(mouse.x,mouse.y);
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x - cpos.x, mouse.y - cpos.y);
                    main.x += delta.x;
                    main.y += delta.y;
                }
            }
        }

        Row {
            id: row1
            spacing: main.rowSpacing
            FunctionKey{id: keyEsc; keySymbolLevel1: "Esc"}
            FunctionKey{id: keyF1; keySymbolLevel1: "F1"}
            FunctionKey{id: keyF2; keySymbolLevel1: "F2"}
            FunctionKey{id: keyF3; keySymbolLevel1: "F3"}
            FunctionKey{id: keyF4; keySymbolLevel1: "F4"}
            FunctionKey{id: keyF5; keySymbolLevel1: "F5"}
            FunctionKey{id: keyF6; keySymbolLevel1: "F6"}
            FunctionKey{id: keyF7; keySymbolLevel1: "F7"}
            FunctionKey{id: keyF8; keySymbolLevel1: "F8"}
            FunctionKey{id: keyF9; keySymbolLevel1: "F9"}
            FunctionKey{id: keyF10; keySymbolLevel1: "F10"}
            FunctionKey{id: keyF11; keySymbolLevel1: "F11"}
            FunctionKey{id: keyF12; keySymbolLevel1: "F12"}
            FunctionKey{id: keyDel; keySymbolLevel1: "Delete"}
            FunctionKey{id: keyHome; keySymbolLevel1: "Home"}
            FunctionKey{id: keyPageUp; keySymbolLevel1: "PgUp"}
            FunctionKey{id: keyPageDown; keySymbolLevel1: "PgDn"}
            FunctionKey{id: keyEnd; keySymbolLevel1: "End"}


        }


        Row {
            id: row2
            spacing: main.rowSpacing

            NumericKey{id: keyCoute; keySymbolLevel1: "\""; keySymbolLevel2: "é"}
            NumericKey{id: key1; keySymbolLevel1: "1"; keySymbolLevel2: "!"}
            NumericKey{id: key2; keySymbolLevel1: "2"; keySymbolLevel2: "'"; keySymbolLevel3: "£"}
            NumericKey{id: key3; keySymbolLevel1: "3"; keySymbolLevel2: "^"; keySymbolLevel3: "#"}
            NumericKey{id: key4; keySymbolLevel1: "4"; keySymbolLevel2: "+"; keySymbolLevel3: "$"}
            NumericKey{id: key5; keySymbolLevel1: "5"; keySymbolLevel2: "%"; keySymbolLevel3: "½"}
            NumericKey{id: key6; keySymbolLevel1: "6"; keySymbolLevel2: "&"}
            NumericKey{id: key7; keySymbolLevel1: "7"; keySymbolLevel2: "/"; keySymbolLevel3: "{"}
            NumericKey{id: key8; keySymbolLevel1: "8"; keySymbolLevel2: "("; keySymbolLevel3: "["}
            NumericKey{id: key9; keySymbolLevel1: "9"; keySymbolLevel2: ")"; keySymbolLevel3: "]"}
            NumericKey{id: key0; keySymbolLevel1: "0"; keySymbolLevel2: "="; keySymbolLevel3: "}"}
            NumericKey{id: keyStar; keySymbolLevel1: "*"; keySymbolLevel2: "?"; keySymbolLevel3: "\\"}
            NumericKey{id: keyMinus; keySymbolLevel1: "-"; keySymbolLevel2: "_"}
            SpecialKey{id: keyBackspace; keySymbolLevel1: "← Backspace"; keyWidth: main.keyWidth * 21/10}
        }


        Row {
            id: row3
            spacing: main.rowSpacing

            SpecialKey{id:keyTab; keySymbolLevel1: "Tab ↔"; keyWidth: main.keyWidth* 3/2}
            AlphaKey{id: keyQ; keySymbolLevel1: "Q"; keySymbolLevel3: "@"}
            AlphaKey{id: keyW; keySymbolLevel1: "W"}
            AlphaKey{id: keyE; keySymbolLevel1: "E"; keySymbolLevel3: "€"}
            AlphaKey{id: keyR; keySymbolLevel1: "R"}
            AlphaKey{id: keyT; keySymbolLevel1: "T"}
            AlphaKey{id: keyY; keySymbolLevel1: "Y"}
            AlphaKey{id: keyU; keySymbolLevel1: "U"}
            AlphaKey{id: keyI; keySymbolLevel1: "I"}
            AlphaKey{id: keyO; keySymbolLevel1: "O"}
            AlphaKey{id: keyP; keySymbolLevel1: "P"}
            AlphaKey{id: keyGG; keySymbolLevel1: "Ğ"; keySymbolLevel3: "¨"}
            AlphaKey{id: keyUU; keySymbolLevel1: "Ü"; keySymbolLevel3: "~"}

        }
        Row {
            id: row4
            spacing: main.rowSpacing

            StickyKey{id:keyCapsLock; keySymbolLevel1: "CapsLock"; keyWidth: main.keyWidth * 9 / 5;onClickedSticky:{ main.keyCapsPressed=true}}
            AlphaKey{id: keyA; keySymbolLevel1: "A"}
            AlphaKey{id: keyS; keySymbolLevel1: "S"}
            AlphaKey{id: keyD; keySymbolLevel1: "D"}
            AlphaKey{id: keyF; keySymbolLevel1: "F"}
            AlphaKey{id: keyG; keySymbolLevel1: "G"}
            AlphaKey{id: keyH; keySymbolLevel1: "H"}
            AlphaKey{id: keyJ; keySymbolLevel1: "J"}
            AlphaKey{id: keyK; keySymbolLevel1: "K"}
            AlphaKey{id: keyL; keySymbolLevel1: "L"}
            AlphaKey{id: keySS; keySymbolLevel1: "Ş"; keySymbolLevel3: "´"}
            AlphaKey{id: keyII; keySymbolLevel1: "İ"}
            NumericKey{id: keyComma; keySymbolLevel1: ","; keySymbolLevel2: ";"; keySymbolLevel3: "`"}


        }
        Row {
            id: row5
            spacing: main.rowSpacing

            StickyKey{id:keyShiftL; keySymbolLevel1: "Shift"; keyWidth: main.keyWidth;onClickedSticky:{ main.keyCapsPressed=true; main.engine(keySymbolLevel1)}}
            AlphaKey{id: keyCompare; keySymbolLevel1: "<"; keySymbolLevel2: ">"; keySymbolLevel3: "|"}
            AlphaKey{id: keyZ; keySymbolLevel1: "Z"}
            AlphaKey{id: keyX; keySymbolLevel1: "X"}
            AlphaKey{id: keyC; keySymbolLevel1: "C"}
            AlphaKey{id: keyV; keySymbolLevel1: "V"}
            AlphaKey{id: keyB; keySymbolLevel1: "B"}
            AlphaKey{id: keyN; keySymbolLevel1: "N"}
            AlphaKey{id: keyM; keySymbolLevel1: "M"}
            AlphaKey{id: keyOO; keySymbolLevel1: "Ö"}
            AlphaKey{id: keyCC; keySymbolLevel1: "Ç"}
            NumericKey{id: keyDot; keySymbolLevel1: ".";keySymbolLevel2: ":"}

        }
        Row {
            id: row6
            spacing: main.rowSpacing
            SettingsKey{id: keySettings}
            StickyKey{id: keyCtrlL; keySymbolLevel1: "Ctrl"; keyWidth: main.keyWidth;onClickedSticky:{ main.keyCapsPressed=true; main.engine(keySymbolLevel1)}}
            MetaKey{id: keyMeta}
            StickyKey{id: keyAlt; keySymbolLevel1: "Alt"; keyWidth: main.keyWidth;onClickedSticky:{ main.keyCapsPressed=true; main.engine(keySymbolLevel1)}}
            AlphaKey{id: keySpace; keySymbolLevel1: ""; keyWidth: main.keyWidth * 6 + 5 * main.rowSpacing;}
            StickyKey{id: keyAltGr; keySymbolLevel1: "Alt Gr"; keyWidth: main.keyWidth;onClickedSticky:{ main.keyCapsPressed=true; main.engine(keySymbolLevel1)}}
            StickyKey{id: keyCtrlR; keySymbolLevel1: "Ctrl"; keyWidth: main.keyWidth;onClickedSticky:{ main.keyCapsPressed=true; main.engine(keySymbolLevel1)}}
            ArrowKey{id: keyArrowL; keySymbolLevel1: "◄"}
            ArrowKey{id: keyArrowB; keySymbolLevel1: "▼"}
            ArrowKey{id: keyArrowR; keySymbolLevel1: "►"}
        }


    }



    EnterKey{
        id: keyEnter
        x: keyUU.x + main.keyWidth + main.rowSpacing
        y: row3.y
    }
    ArrowKey{
        id: keyArrowU
        x: keyDot.x + main.keyWidth * 2 + main.rowSpacing * 2
        y: row5.y
        keySymbolLevel1: "▲"
    }





    Component.onCompleted: {
        dock.height = Screen.height / 30
        main.keyHeight = Screen.height / 16
        main.width = main.keyHeight * 16.4
        main.height = main.keyHeight * 6 + dock.height + main.columnSpacing
    }
*/


}

