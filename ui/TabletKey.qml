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

// TabletKey

Key {
    id: key

    property int keyCodeSymbol
    property int symbolLevel
    fontPointSize: main.keyHeight / 3

    leVis4: true
    keyText: main.symbolMode ?
                 helper.getSymbol(key.keyCodeSymbol,main.languageLayoutIndex,key.symbolLevel)
               : helper.getSymbol(key.keyCode,main.languageLayoutIndex,main.keyLevel)

    mirror: true

    MouseArea {
        id: ma
        anchors.fill: parent

        onEntered: {
            btnHovered()
        }

        onExited: {
            btnHovered()
        }

        onPressed: {
            btnPressed()
            if (main.symbolMode){
                main.fakeKeyTablet(key.keyCodeSymbol, key.symbolLevel,key.keyText)
            }
            else{
                main.nonStickyPressed(key.keyCode,true,false)
            }
         }

        onPressAndHold: {
            btnHold()
        }

        onReleased: {
            btnReleased()
            if (!main.symbolMode)
                main.nonStickyReleased(key.keyCode)
        }

        onClicked: {
            btnClicked()
        }
    }
}
