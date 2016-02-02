import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0

Item{
    id: fullLayout

    property bool releaseAll : main.releaseAll

    onReleaseAllChanged: releaseAllSticky()


    function releaseAllSticky(){

        keyShiftL.releaseBtn()
        keyCtrlL.releaseBtn()
        keyMeta.releaseBtn()
        keyAlt.releaseBtn()
        keyAltGr.releaseBtn()
        keyCtrlR.releaseBtn()

}


    Helper {
        id:helperId
    }




    Column{
        id: col1
        spacing: main.columnSpacing


        Rectangle {
            id: dock
            height: main.dockSize
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
            FunctionKey{id: keyEsc; keySymbolLevel1: "Esc"; keyCode: 9}
            FunctionKey{id: keyF1; keySymbolLevel1: "F1"; keyCode: 67}
            FunctionKey{id: keyF2; keySymbolLevel1: "F2"; keyCode: 68}
            FunctionKey{id: keyF3; keySymbolLevel1: "F3"; keyCode: 69}
            FunctionKey{id: keyF4; keySymbolLevel1: "F4"; keyCode: 70}
            FunctionKey{id: keyF5; keySymbolLevel1: "F5"; keyCode: 71}
            FunctionKey{id: keyF6; keySymbolLevel1: "F6"; keyCode: 72}
            FunctionKey{id: keyF7; keySymbolLevel1: "F7"; keyCode: 73}
            FunctionKey{id: keyF8; keySymbolLevel1: "F8"; keyCode: 74}
            FunctionKey{id: keyF9; keySymbolLevel1: "F9"; keyCode: 75}
            FunctionKey{id: keyF10; keySymbolLevel1: "F10"; keyCode: 76}
            FunctionKey{id: keyF11; keySymbolLevel1: "F11"; keyCode: 95}
            FunctionKey{id: keyF12; keySymbolLevel1: "F12"; keyCode: 96}
            FunctionKey{id: keyDel; keySymbolLevel1: "Delete"; keyCode: 119}
            FunctionKey{id: keyHome; keySymbolLevel1: "Home"; keyCode: 110}
            FunctionKey{id: keyPageUp; keySymbolLevel1: "PgUp"; keyCode: 112}
            FunctionKey{id: keyPageDown; keySymbolLevel1: "PgDn"; keyCode: 117}
            FunctionKey{id: keyEnd; keySymbolLevel1: "End"; keyCode: 115}


        }


        Row {
            id: row2
            spacing: main.rowSpacing

            NumericKey{id: keyCoute; keyCode: 49}
            NumericKey{id: key1; keyCode: 10}
            NumericKey{id: key2; keyCode: 11}
            NumericKey{id: key3; keyCode: 12}
            NumericKey{id: key4; keyCode: 13}
            NumericKey{id: key5; keyCode: 14}
            NumericKey{id: key6; keyCode: 15}
            NumericKey{id: key7; keyCode: 16}
            NumericKey{id: key8; keyCode: 17}
            NumericKey{id: key9; keyCode: 18}
            NumericKey{id: key0; keyCode: 19}
            NumericKey{id: keyStar; keyCode: 20}
            NumericKey{id: keyMinus; keyCode: 21}
            SpecialKey{id: keyBackspace; keySymbolLevel1: "← Backspace"; keyWidth: main.keyWidth * 21/10; keyCode: 22}
        }


        Row {
            id: row3
            spacing: main.rowSpacing

            SpecialKey{id:keyTab; keySymbolLevel1: "Tab ↔"; keyWidth: main.keyWidth* 3/2; keyCode: 23}
            AlphaKey{id: keyQ; keyCode: 24; isLevel2Visible: true}
            AlphaKey{id: keyW; keyCode: 25}
            AlphaKey{id: keyE; keyCode: 26; isLevel2Visible: true}
            AlphaKey{id: keyR; keyCode: 27}
            AlphaKey{id: keyT; keyCode: 28}
            AlphaKey{id: keyY; keyCode: 29}
            AlphaKey{id: keyU; keyCode: 30}
            AlphaKey{id: keyI; keyCode: 31}
            AlphaKey{id: keyO; keyCode: 32}
            AlphaKey{id: keyP; keyCode: 33}
            AlphaKey{id: keyGG; keyCode: 34}
            AlphaKey{id: keyUU; keyCode: 35; isLevel2Visible: true}

        }
        Row {
            id: row4
            spacing: main.rowSpacing

            StickyKey{id:keyCapsLock; keySymbolLevel1: "CapsLock"; keyWidth: main.keyWidth * 9 / 5; keyCode: 66}
            AlphaKey{id: keyA; keyCode: 38}
            AlphaKey{id: keyS; keyCode: 39}
            AlphaKey{id: keyD; keyCode: 40}
            AlphaKey{id: keyF; keyCode: 41}
            AlphaKey{id: keyG; keyCode: 42}
            AlphaKey{id: keyH; keyCode: 43}
            AlphaKey{id: keyJ; keyCode: 44}
            AlphaKey{id: keyK; keyCode: 45}
            AlphaKey{id: keyL; keyCode: 46}
            AlphaKey{id: keySS; keyCode: 47}
            AlphaKey{id: keyII; keyCode: 48}
            NumericKey{id: keyComma;keyCode: 51 }


        }
        Row {
            id: row5
            spacing: main.rowSpacing

            StickyKey{id:keyShiftL; keySymbolLevel1: "Shift"; keyWidth: main.keyWidth; keyCode: 50}
            NumericKey{id: keyCompare; keyCode: 94 }
            AlphaKey{id: keyZ; keyCode: 52}
            AlphaKey{id: keyX; keyCode: 53}
            AlphaKey{id: keyC; keyCode: 54}
            AlphaKey{id: keyV; keyCode: 55}
            AlphaKey{id: keyB; keyCode: 56}
            AlphaKey{id: keyN; keyCode: 57}
            AlphaKey{id: keyM; keyCode: 58}
            AlphaKey{id: keyOO; keyCode: 59}
            AlphaKey{id: keyCC; keyCode: 60}
            NumericKey{id: keyDot; keyCode: 61; isLevel3Visible: false}

        }
        Row {
            id: row6
            spacing: main.rowSpacing
            SettingsKey{id: keySettings}
            StickyKey{id: keyCtrlL; keySymbolLevel1: "Ctrl"; keyWidth: main.keyWidth;keyCode: 37}
            MetaKey{id: keyMeta; keyCode: 133}
            StickyKey{id: keyAlt; keySymbolLevel1: "Alt"; keyWidth: main.keyWidth;keyCode: 64}
            AlphaKey{id: keySpace; keyWidth: main.keyWidth * 6 + 5 * main.rowSpacing;}
            StickyKey{id: keyAltGr; keySymbolLevel1: "Alt Gr"; keyWidth: main.keyWidth; keyCode: 108}
            StickyKey{id: keyCtrlR; keySymbolLevel1: "Ctrl"; keyWidth: main.keyWidth;keyCode: 105}
            ArrowKey{id: keyArrowL; keySymbolLevel1: "◄"; keyCode: 113}
            ArrowKey{id: keyArrowB; keySymbolLevel1: "▼"; keyCode: 116}
            ArrowKey{id: keyArrowR; keySymbolLevel1: "►"; keyCode: 114}
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
        keyCode: 111
    }


}
