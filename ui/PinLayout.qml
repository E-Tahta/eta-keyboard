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
    id: pinLayout

    property bool releaseAll : main.releaseAll
    property bool updateTheme: main.updateTheme
    property variant keyCodesArr: [19,10,11,12,13,14,15,16,17,18]
    property variant keyShuffledArr: []
    property bool shuffle: main.shuffle


    function getKeyCode(index){
        if (pinLayout.shuffle) {
            return keyShuffledArr[index]
        } else {
            return keyCodesArr[index]
        }

    }

    function shuffleList(){
        var j, x, i, a;
        a = keyCodesArr
        for (i = a.length; i; i -= 1) {
            j = Math.floor(Math.random() * i);
            x = a[i - 1];
            a[i - 1] = a[j];
            a[j] = x;
        }
        keyShuffledArr = a
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
                id: row1
                spacing: main.spacing

                TabletKey {id: key7; keyCode: getKeyCode(7);
                    keyCodeSymbol: getKeyCode(7); symbolLevel: 0}
                TabletKey {id: key8; keyCode: getKeyCode(8);
                    keyCodeSymbol: getKeyCode(8); symbolLevel: 0}
                TabletKey {id: key9; keyCode: getKeyCode(9);
                    keyCodeSymbol: getKeyCode(9); symbolLevel: 0}

             }

            Row {
                id: row2
                spacing: main.spacing

                TabletKey{id: key4; keyCode: getKeyCode(4);
                    keyCodeSymbol: getKeyCode(4); symbolLevel: 0}
                TabletKey{id: key5; keyCode: getKeyCode(5);
                    keyCodeSymbol: getKeyCode(5); symbolLevel: 0}
                TabletKey{id: key6; keyCode: getKeyCode(6);
                    keyCodeSymbol: getKeyCode(6); symbolLevel: 0}

            }
            Row {
                id: row3
                spacing: main.spacing

                TabletKey{id: key1; keyCode: getKeyCode(1);
                    keyCodeSymbol: getKeyCode(1); symbolLevel: 0}
                TabletKey{id: key2; keyCode: getKeyCode(2);
                    keyCodeSymbol: getKeyCode(2); symbolLevel: 0}
                TabletKey{id: key3; keyCode: getKeyCode(3);
                    keyCodeSymbol: getKeyCode(3); symbolLevel: 0}

            }
            Row {
                id: row4
                spacing: main.spacing

                StickyKey{
                    id: keySymbols
                    keyText: "Karıştır"
                    keyCode: 560
                    lock: main.shuffle
                    keyWidth: main.keyWidth * 2 + main.spacing
                }
                TabletKey{id: key0; keyCode: getKeyCode(0);
                    keyCodeSymbol: getKeyCode(0); symbolLevel: 0}
            }
        }

        AlphaNumericKey{id: keyBackspace
            keyText: "←"
            keyCode: 22
            leVis4: true
            mirror: false
            keyHeight: main.keyHeight * 2 + main.spacing
            fontPointSize: main.keyHeight / 2
            x: key9.x + main.keyWidth + main.spacing * 2
            y: row1.y + main.spacing
        }
        AlphaNumericKey {
            id: keyEnter
            keyText: "\u23CE"
            keyHeight: main.keyHeight * 2 + main.spacing
            keyCode: 36
            fontPointSize: main.keyWidth ? main.keyWidth / 2 : 2
            leVis4: true
            mirror: false
            x: key3.x + main.keyWidth + main.spacing * 2
            y: row3.y + main.spacing
        }
    }

    onReleaseAllChanged: {

    }

    onShuffleChanged: {
        shuffleList()
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
