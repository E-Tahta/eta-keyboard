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
        keyCtrlR.releaseBtn()
        keyMeta.releaseBtn()
        keyAlt.releaseBtn()
        keyAltGr.releaseBtn()

        main.keyLevel = 0
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


            ListModel {
                id:comboModel

            }


            ComboBox{
                id:languages
                editable: false
                model: comboModel
                onCurrentIndexChanged: {
                    main.languageLayoutIndex = currentIndex;
                    helperId.setLayout(comboModel.get(currentIndex).text);

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
                    left: languages.right
                    bottom: dock.bottom
                    right:closeBtnImage.left
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
            FunctionKey{id: keyEsc; keyText: "Esc"; keyCode: 9}
            FunctionKey{id: keyF1; keyText: "F1"; keyCode: 67}
            FunctionKey{id: keyF2; keyText: "F2"; keyCode: 68}
            FunctionKey{id: keyF3; keyText: "F3"; keyCode: 69}
            FunctionKey{id: keyF4; keyText: "F4"; keyCode: 70}
            FunctionKey{id: keyF5; keyText: "F5"; keyCode: 71}
            FunctionKey{id: keyF6; keyText: "F6"; keyCode: 72}
            FunctionKey{id: keyF7; keyText: "F7"; keyCode: 73}
            FunctionKey{id: keyF8; keyText: "F8"; keyCode: 74}
            FunctionKey{id: keyF9; keyText: "F9"; keyCode: 75}
            FunctionKey{id: keyF10; keyText: "F10"; keyCode: 76}
            FunctionKey{id: keyF11; keyText: "F11"; keyCode: 95}
            FunctionKey{id: keyF12; keyText: "F12"; keyCode: 96}
            FunctionKey{id: keyDel; keyText: "Delete"; keyCode: 119}
            FunctionKey{id: keyHome; keyText: "Home"; keyCode: 110}
            FunctionKey{id: keyPageUp; keyText: "PgUp"; keyCode: 112}
            FunctionKey{id: keyPageDown; keyText: "PgDn"; keyCode: 117}
            FunctionKey{id: keyEnd; keyText: "End"; keyCode: 115}


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
            AlphaNumericKey{id: keyQ; keyCode: 24; leVis2: true}
            AlphaNumericKey{id: keyW; keyCode: 25}
            AlphaNumericKey{id: keyE; keyCode: 26}
            AlphaNumericKey{id: keyR; keyCode: 27}
            AlphaNumericKey{id: keyT; keyCode: 28}
            AlphaNumericKey{id: keyY; keyCode: 29}
            AlphaNumericKey{id: keyU; keyCode: 30}
            AlphaNumericKey{id: keyI; keyCode: 31}
            AlphaNumericKey{id: keyO; keyCode: 32}
            AlphaNumericKey{id: keyP; keyCode: 33}
            AlphaNumericKey{id: keyGG; keyCode: 34}
            AlphaNumericKey{id: keyUU; keyCode: 35; leVis2: true}

        }
        Row {
            id: row4
            spacing: main.rowSpacing

            CapsLockKey{id:keyCapsLock; keySymbolLevel1: "CapsLock"; keyWidth: main.keyWidth * 9 / 5; keyCode: 66}
            AlphaNumericKey{id: keyA; keyCode: 38}
            AlphaNumericKey{id: keyS; keyCode: 39}
            AlphaNumericKey{id: keyD; keyCode: 40}
            AlphaNumericKey{id: keyF; keyCode: 41}
            AlphaNumericKey{id: keyG; keyCode: 42}
            AlphaNumericKey{id: keyH; keyCode: 43}
            AlphaNumericKey{id: keyJ; keyCode: 44}
            AlphaNumericKey{id: keyK; keyCode: 45}
            AlphaNumericKey{id: keyL; keyCode: 46}
            AlphaNumericKey{id: keySS; keyCode: 47}
            AlphaNumericKey{id: keyII; keyCode: 48}
            AlphaNumericKey{id: keyComma;keyCode: 51 }


        }
        Row {
            id: row5
            spacing: main.rowSpacing

            StickyKey{id:keyShiftL; keySymbolLevel1: "Shift"; keyWidth: main.keyWidth; keyCode: 50}
            AlphaNumericKey{id: keyCompare; keyCode: 94 }
            AlphaNumericKey{id: keyZ; keyCode: 52}
            AlphaNumericKey{id: keyX; keyCode: 53}
            AlphaNumericKey{id: keyC; keyCode: 54}
            AlphaNumericKey{id: keyV; keyCode: 55}
            AlphaNumericKey{id: keyB; keyCode: 56}
            AlphaNumericKey{id: keyN; keyCode: 57}
            AlphaNumericKey{id: keyM; keyCode: 58}
            AlphaNumericKey{id: keyOO; keyCode: 59}
            AlphaNumericKey{id: keyCC; keyCode: 60}
            AlphaNumericKey{id: keyDot; keyCode: 61}

        }
        Row {
            id: row6
            spacing: main.rowSpacing
            SettingsKey{id: keySettings}
            StickyKey{id: keyCtrlL; keySymbolLevel1: "Ctrl"; keyWidth: main.keyWidth;keyCode: 37}
            MetaKey{id: keyMeta; keyCode: 133}
            StickyKey{id: keyAlt; keySymbolLevel1: "Alt"; keyWidth: main.keyWidth;keyCode: 64}
            AlphaNumericKey{id: keySpace; keyWidth: main.keyWidth * 6 + 5 * main.rowSpacing; keyCode: 65}
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
        keyCode: 36
    }
    ArrowKey{
        id: keyArrowU
        x: keyDot.x + main.keyWidth * 2 + main.rowSpacing * 2
        y: row5.y
        keySymbolLevel1: "▲"
        keyCode: 111
    }


    Component.onCompleted: {

        for(var i = 0; i< helperId.getNumberOfLayouts();i++)
        {
            comboModel.append({text:helperId.getLayoutName(i)});


        }

    }


}
