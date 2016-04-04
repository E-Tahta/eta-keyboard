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
    id: tabletLayout

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
                id: row3
                spacing: main.spacing

                TabletKey {id: keyQ; keyCode: 24; keyCodeSymbol: 10; symbolLevel: 0}
                TabletKey {id: keyW; keyCode: 25; keyCodeSymbol: 11; symbolLevel: 0}
                TabletKey {id: keyE; keyCode: 26; keyCodeSymbol: 12; symbolLevel: 0}
                TabletKey {id: keyR; keyCode: 27; keyCodeSymbol: 13; symbolLevel: 0}
                TabletKey {id: keyT; keyCode: 28; keyCodeSymbol: 14; symbolLevel: 0}
                TabletKey {id: keyY; keyCode: 29; keyCodeSymbol: 15; symbolLevel: 0}
                TabletKey {id: keyU; keyCode: 30; keyCodeSymbol: 16; symbolLevel: 0}
                TabletKey {id: keyI; keyCode: 31; keyCodeSymbol: 17; symbolLevel: 0}
                TabletKey {id: keyO; keyCode: 32; keyCodeSymbol: 18; symbolLevel: 0}
                TabletKey {id: keyP; keyCode: 33; keyCodeSymbol: 19; symbolLevel: 0}
                TabletKey {id: keyGG; keyCode: 34; keyCodeSymbol: 16; symbolLevel: 2}
                TabletKey {id: keyUU; keyCode: 35; keyCodeSymbol: 19; symbolLevel: 2}
             }

            Row {
                id: row4
                spacing: main.spacing
                //anchors.centerIn: col1
                Key{id:splitter; width: (main.keyWidth-main.spacing) / 2; opacity: 0}
                TabletKey{id: keyA; keyCode: 38; keyCodeSymbol: 24; symbolLevel: 2}
                TabletKey{id: keyS; keyCode: 39; keyCodeSymbol: 12; symbolLevel: 2}
                TabletKey{id: keyD; keyCode: 40; keyCodeSymbol: 13; symbolLevel: 2}
                TabletKey{id: keyF; keyCode: 41; keyCodeSymbol: 14; symbolLevel: 1}
                TabletKey{id: keyG; keyCode: 42; keyCodeSymbol: 15; symbolLevel: 1}
                TabletKey{id: keyH; keyCode: 43; keyCodeSymbol: 17; symbolLevel: 1}
                TabletKey{id: keyJ; keyCode: 44; keyCodeSymbol: 18; symbolLevel: 1}
                TabletKey{id: keyK; keyCode: 45; keyCodeSymbol: 21; symbolLevel: 0}
                TabletKey{id: keyL; keyCode: 46; keyCodeSymbol: 94; symbolLevel: 0}
                TabletKey{id: keySS; keyCode: 47; keyCodeSymbol: 94; symbolLevel: 1}
                TabletKey{id: keyII; keyCode: 48; keyCodeSymbol: 10; symbolLevel: 1}

            }
            Row {
                id: row5
                spacing: main.spacing

                StickyKey{id:keyShiftL; keyText: "Shift"; keyCode: 50;
                    keyWidth: main.keyWidth + main.spacing + splitter.width
                    lock: main.btnShift
                }
                TabletKey{id: keyZ; keyCode: 52; keyCodeSymbol: 51; symbolLevel: 1}
                TabletKey{id: keyX; keyCode: 53; keyCodeSymbol: 61; symbolLevel: 1}
                TabletKey{id: keyC; keyCode: 54; keyCodeSymbol: 11; symbolLevel: 1}
                TabletKey{id: keyV; keyCode: 55; keyCodeSymbol: 49; symbolLevel: 0}
                TabletKey{id: keyB; keyCode: 56; keyCodeSymbol: 20; symbolLevel: 1}
                TabletKey{id: keyN; keyCode: 57; keyCodeSymbol: 16; symbolLevel: 1}
                TabletKey{id: keyM; keyCode: 58; keyCodeSymbol: 13; symbolLevel: 1}
                TabletKey{id: keyOO; keyCode: 59; keyCodeSymbol: 19; symbolLevel: 1}
                TabletKey{id: keyCC; keyCode: 60; keyCodeSymbol: 21; symbolLevel: 1}
                AlphaNumericKey{id: keyBackspace; keyText: "←"; keyCode: 22; leVis4: true; mirror: false; keyWidth: main.keyWidth + main.spacing + splitter.width; fontPointSize: main.keyHeight / 2}
            }

            Row {
                id: row6
                spacing: main.spacing

                SettingsKey{id: keySettings}
                StickyKey{
                    id: keySymbols
                    keyText: "12!?"
                    keyCode: 500
                    lock: main.symbolMode
                }
                TabletKey{id: keyComma; keyCode: 51; keyCodeSymbol: 51; symbolLevel: 0}
                AlphaNumericKey{id: keySpace;
                    keyWidth: main.keyWidth * 6 + main.spacing * 5 ; keyCode: 65}
                TabletKey{id: keyDot; keyCode: 61; keyCodeSymbol: 61; symbolLevel: 0}
                AlphaNumericKey {
                    id: keyEnter
                    keyText: "\u23CE"
                    keyWidth: main.keyWidth * 2 + main.spacing
                    keyCode: 36
                    fontPointSize: main.keyHeight ? keyHeight / 2 : 2
                    leVis4: true
                    mirror: false
                }
            }
        }
    }

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
