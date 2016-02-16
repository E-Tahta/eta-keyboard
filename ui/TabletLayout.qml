/*****************************************************************************
 *   Copyright (C) 2016 by Hikmet Bas                                        *
 *   <hikmet.bask@pardus.org.tr>                                             *
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
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0

Item{
    id: tabletLayout

    property bool releaseAll : main.releaseAll
    property bool updateTheme: main.updateTheme


    Helper {
        id:helperId


    }

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


                AlphaNumericKey{id: keyQ; keyCode: 24; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyW; keyCode: 25; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyE; keyCode: 26; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyR; keyCode: 27; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyT; keyCode: 28; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyY; keyCode: 29; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyU; keyCode: 30; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyI; keyCode: 31; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyO; keyCode: 32; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyP; keyCode: 33; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyGG; keyCode: 34; keyWidth: (11 * main.keyWidth - main.spacing) / 12}
                AlphaNumericKey{id: keyUU; keyCode: 35; keyWidth: (11 * main.keyWidth - main.spacing) / 12}



            }
            Row {
                id: row4
                spacing: main.spacing


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



            }
            Row {
                id: row5
                spacing: main.spacing

                StickyKey{id:keyShiftL; keyText: "Shift"; keyWidth: main.keyWidth; keyCode: 50}

                AlphaNumericKey{id: keyZ; keyCode: 52}
                AlphaNumericKey{id: keyX; keyCode: 53}
                AlphaNumericKey{id: keyC; keyCode: 54}
                AlphaNumericKey{id: keyV; keyCode: 55}
                AlphaNumericKey{id: keyB; keyCode: 56}
                AlphaNumericKey{id: keyN; keyCode: 57}
                AlphaNumericKey{id: keyM; keyCode: 58}
                AlphaNumericKey{id: keyOO; keyCode: 59}
                AlphaNumericKey{id: keyCC; keyCode: 60}
                SpecialKey{id: keyBackspace; keyText: "←"; keyWidth: main.keyWidth; keyCode: 22}


            }
            Row {
                id: row6
                spacing: main.spacing
                SettingsKey{id: keySettings}
                SpecialKey{id: keyNum; keyText: "12!?"; keyWidth: main.keyWidth ; keyCode: 133}
                SpecialKey{id: keyEmoji; keyText: "\u263A"; keyWidth: main.keyWidth; keyCode: 133; fontPointSize: keyHeight / 2 }
                AlphaNumericKey{id: keyComma;keyCode: 51}
                AlphaNumericKey{id: keySpace; keyWidth: main.keyWidth * 4 + main.spacing * 4 ; keyCode: 65}
                AlphaNumericKey{id: keyDot; keyCode: 61}
                AlphaNumericKey{id: keyEnter; keyText: "\u23CE"; keyWidth: main.keyWidth * 2; keyCode: 36; fontPointSize: keyHeight / 2; leVis4: true}

            }


        }


    }



    onUpdateThemeChanged: {
        passwordToggle.color = pToggleMa.containsMouse ? main.keyHoverColor : main.keyColor
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
