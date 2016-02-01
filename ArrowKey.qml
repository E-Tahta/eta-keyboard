import QtQuick 2.0

Rectangle {

    id: arwKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth : main.keyWidth
    property int keyHeight: main.keyHeight


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10

    property bool hold: false
    property bool entered: false
    Text {
        id: symbol
        color: textColor
        font.pointSize: keyHeight * 3 / 15
        anchors {
            centerIn: arwKey
        }
        text: keySymbolLevel1
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (!arwKey.hold){
                arwKey.color = arwKey.keyHoverColor
                symbol.color = arwKey.textColor


            }
            arwKey.entered = true
        }

        onExited: {
            if (!arwKey.hold){
                arwKey.color = arwKey.keyColor
                symbol.color = arwKey.textColor


            }
            arwKey.entered = false
        }

        onPressed: {
            arwKey.color = arwKey.keyPressedColor
            symbol.color = arwKey.textPressedColor

            main.nonStickyPressed(arwKey.keySymbolLevel1)



        }
        onPressAndHold: {
            arwKey.color = arwKey.keyPressedColor
            symbol.color = arwKey.textPressedColor


            arwKey.hold = true


        }
        onReleased: {
            arwKey.hold = false
            if (!arwKey.entered){
                arwKey.color = arwKey.keyColor
                symbol.color = arwKey.textColor


            }
            else {
                arwKey.color = arwKey.keyHoverColor
                symbol.color = arwKey.textColor


            }

        }
    }
}
