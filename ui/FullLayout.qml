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

Item{
    id: fullLayout

    property bool releaseAll : main.releaseAll
    property bool updateTheme: main.updateTheme


    Rectangle{
        id: container
        color: main.color

        Column{
            id: col1
            spacing: main.spacing
            anchors{
                top: container.top
                left: container.left
                margins: main.spacing
            }

            Row {
                id: row1
                spacing: main.spacing

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
                spacing: main.spacing

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
                AlphaNumericKey{id: keyBackspace; leVis4: true; keyText: "← Backspace"; keyWidth: main.keyWidth * 2 + main.spacing ; keyCode: 22; mirror: false}
            }

            Row {
                id: row3
                spacing: main.spacing

                AlphaNumericKey{id:keyTab; leVis4: true; keyText: "Tab ↔"; keyWidth: main.keyWidth* 3/2; keyCode: 23}
                AlphaNumericKey{id: keyQ; keyCode: 24; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyW; keyCode: 25; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyE; keyCode: 26; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyR; keyCode: 27; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyT; keyCode: 28; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyY; keyCode: 29; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyU; keyCode: 30; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyI; keyCode: 31; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyO; keyCode: 32; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyP; keyCode: 33; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyGG; keyCode: 34; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyUU; keyCode: 35; leVis0: true; leVis1: true; leVis2: true}
            }

            Row {
                id: row4
                spacing: main.spacing

                CapsLockKey{id:keyCapsLock; keyText: "CapsLock"; keyWidth: main.keyWidth * 7 / 4; keyCode: 66}
                AlphaNumericKey{id: keyA; keyCode: 38; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyS; keyCode: 39; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyD; keyCode: 40; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyF; keyCode: 41; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyG; keyCode: 42; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyH; keyCode: 43; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyJ; keyCode: 44; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyK; keyCode: 45; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyL; keyCode: 46; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keySS; keyCode: 47; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyII; keyCode: 48; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyComma;keyCode: 51; leVis0: true; leVis1: true}
            }

            Row {
                id: row5
                spacing: main.spacing

                StickyKey{id:keyShiftL; keyText: "Shift"; keyWidth: main.keyWidth;
                    keyCode: 50; lock: main.btnShift}
                NumericKey{id: keyCompare; keyCode: 94}
                AlphaNumericKey{id: keyZ; keyCode: 52; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyX; keyCode: 53; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyC; keyCode: 54; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyV; keyCode: 55; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyB; keyCode: 56; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyN; keyCode: 57; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyM; keyCode: 58; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyOO; keyCode: 59; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyCC; keyCode: 60; leVis0: true; leVis1: true}
                AlphaNumericKey{id: keyDot; keyCode: 61; leVis0: true; leVis1: true}
            }

            Row {
                id: row6
                spacing: main.spacing

                SettingsKey{id: keySettings}
                StickyKey{id: keyCtrlL; keyText: "Ctrl"; keyWidth: main.keyWidth;
                    keyCode: 37; lock: main.btnCtrl}
                MetaKey{id: keyMeta; keyCode: 133; lock: main.btnMeta}
                StickyKey{id: keyAlt; keyText: "Alt"; keyWidth: main.keyWidth;
                    keyCode: 64; lock: main.btnAlt}
                AlphaNumericKey{id: keySpace; keyWidth: main.keyWidth * 7 + 6 * main.spacing; keyCode: 65}
                StickyKey{id: keyAltGr; keyText: "Alt Gr"; keyWidth: main.keyWidth;
                    keyCode: 108; lock: main.btnAltGr}
                AlphaNumericKey{id: keyArrowL; leVis4: true; keyText: "◄"; keyCode: 113}
                AlphaNumericKey{id: keyArrowB; leVis4: true; keyText: "▼"; keyCode: 116}
                AlphaNumericKey{id: keyArrowR; leVis4: true; keyText: "►"; keyCode: 114}
            }
        }//End of the column

        EnterKey{
            id: keyEnter
            x: keyUU.x + main.keyWidth + main.spacing + main.spacing
            y: row3.y + main.spacing
            z: -1
        }

        AlphaNumericKey{
            id: keyArrowU
            x: keyDot.x + main.keyWidth * 2 + main.spacing * 2 + main.spacing
            y: row5.y + main.spacing
            leVis4: true
            keyText: "▲"
            keyCode: 111
        }
    }//End of the container

    onReleaseAllChanged: {

    }

    onUpdateThemeChanged: {
        if (main.password){
            passwordToggle.color = main.keyPressedColor
            pToggleText.color = main.textPressedColor
        }
        else{
            passwordToggle.color = pToggleMa.containsMouse ? main.keyHoverColor : main.keyColor
            pToggleText.color = main.textColor
        }
    }
}
