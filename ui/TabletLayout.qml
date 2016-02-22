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

                AlphaNumericKey{id: keyQ; keyCode: 24; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyW; keyCode: 25; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyE; keyCode: 26; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyR; keyCode: 27; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyT; keyCode: 28; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyY; keyCode: 29; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyU; keyCode: 30; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyI; keyCode: 31; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyO; keyCode: 32; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyP; keyCode: 33; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyGG; keyCode: 34; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyUU; keyCode: 35; leVis0: true; leVis1: true; leVis2: true; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
            }

            Row {
                id: row4
                spacing: main.spacing

                AlphaNumericKey{id: keyA; keyCode: 38; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyS; keyCode: 39; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyD; keyCode: 40; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyF; keyCode: 41; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyG; keyCode: 42; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyH; keyCode: 43; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyJ; keyCode: 44; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyK; keyCode: 45; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyL; keyCode: 46; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keySS; keyCode: 47; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyII; keyCode: 48; leVis0: true; leVis1: true; leVis2: true}
            }
            Row {
                id: row5
                spacing: main.spacing

                StickyKey{id:keyShiftL; keyText: "Shift"; keyWidth: main.keyWidth; keyCode: 50}
                AlphaNumericKey{id: keyZ; keyCode: 52; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyX; keyCode: 53; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyC; keyCode: 54; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyV; keyCode: 55; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyB; keyCode: 56; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyN; keyCode: 57; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyM; keyCode: 58; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyOO; keyCode: 59; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyCC; keyCode: 60; leVis0: true; leVis1: true; leVis2: true}
                AlphaNumericKey{id: keyBackspace; keyText: "←"; keyCode: 22; leVis4: true}
            }

            Row {
                id: row6
                spacing: main.spacing

                SettingsKey{id: keySettings}
                AlphaNumericKey{id: keyNum; leVis4: true; keyText: "12!?"; keyWidth: main.keyWidth ; keyCode: 133}
                AlphaNumericKey {
                    id: keyEmoji
                    leVis4: true
                    keyText: "\u263A"
                    keyWidth: main.keyWidth
                    keyCode: 133
                    fontPointSize:  main.keyHeight ? keyHeight / 2 : 2
                }
                AlphaNumericKey{id: keyComma;keyCode: 51}
                AlphaNumericKey{id: keySpace; keyWidth: main.keyWidth * 4 + main.spacing * 4 ; keyCode: 65}
                AlphaNumericKey{id: keyDot; keyCode: 61}
                AlphaNumericKey {
                    id: keyEnter
                    keyText: "\u23CE"
                    keyWidth: main.keyWidth * 2
                    keyCode: 36
                    fontPointSize: main.keyHeight ? keyHeight / 2 : 2
                    leVis4: true
                }
            }
        }
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
