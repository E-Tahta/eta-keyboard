import QtQuick 2.0

Rectangle {
    id: numKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property string keySymbolLevel2
    property string keySymbolLevel3
    property int keyWidth: main.keyWidth
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
        font.pointSize: keyHeight * 3 / 12
        anchors {
            left: numKey.left
            bottom: numKey.bottom
            margins: keyHeight/10
        }
        text: keySymbolLevel1
    }

    Text {
        id: symbol2
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            left: numKey.left
            top: numKey.top
            margins: keyHeight/10
        }
        text: keySymbolLevel2
    }

    Text {
        id: symbol3
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            right: numKey.right
            bottom: numKey.bottom
            margins: keyHeight/10
        }
        text: keySymbolLevel3
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            numKey.color = keyHoverColor
            symbol.color = textColor
            numKey.entered = true
        }

        onExited: {
            if (!numKey.hold){
                numKey.color = keyColor
                symbol.color = textColor
            }
            numKey.entered = false
        }

        onPressed: {
            numKey.color = keyPressedColor
            symbol.color = textPressedColor
            console.log(symbol.text)

        }
        onPressAndHold: {
            numKey.color = keyPressedColor
            symbol.color = textPressedColor
            numKey.hold = true
            console.log(numKey.hold);

        }
        onReleased: {
            numKey.color = hoveredChanged() ? keyColor : keyHoverColor
            symbol.color = textColor
            numKey.hold = false
            if (!numKey.entered){
                numKey.color = keyColor
                symbol.color = textColor
            }

        }
    }
}
