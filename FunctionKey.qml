import QtQuick 2.0

Rectangle {
    id: funcKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth: main.keyWidth * 49 / 60
    property int keyHeight: main.keyHeight / 2


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/5

    property bool hold: false
    property bool entered: false

    Text {
        id: symbol
        color: textColor
        font.pointSize: keyHeight * 1 / 3
        anchors {
            left: funcKey.left
            top: funcKey.top
            margins: keyHeight/10
        }
        text: keySymbolLevel1
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (!funcKey.hold){
                funcKey.color = funcKey.keyHoverColor
                symbol.color = funcKey.textColor


            }
            funcKey.entered = true
        }

        onExited: {
            if (!funcKey.hold){
                funcKey.color = funcKey.keyColor
                symbol.color = funcKey.textColor


            }
            funcKey.entered = false
        }

        onPressed: {
            funcKey.color = funcKey.keyPressedColor
            symbol.color = funcKey.textPressedColor

main.nonStickyPressed(funcKey.keySymbolLevel1)



        }
        onPressAndHold: {
            funcKey.color = funcKey.keyPressedColor
            symbol.color = funcKey.textPressedColor


            funcKey.hold = true


        }
        onReleased: {
            funcKey.hold = false
            if (!funcKey.entered){
                funcKey.color = funcKey.keyColor
                symbol.color = funcKey.textColor


            }
            else {
                funcKey.color = funcKey.keyHoverColor
                symbol.color = funcKey.textColor


            }

        }
    }
}
