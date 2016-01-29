import QtQuick 2.0

Rectangle {
    id: alpKey

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
            left: alpKey.left
            top: alpKey.top
            margins: keyHeight/10
        }
        text: keySymbolLevel1
    }
    Text {
        id: symbol2
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            left: alpKey.left
            bottom: alpKey.bottom
            margins: keyHeight/10
        }
        text: keySymbolLevel2
    }
    Text {
        id: symbol3
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            right: alpKey.right
            bottom: alpKey.bottom
            margins: keyHeight/10
        }
        text: keySymbolLevel3
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            alpKey.color = keyHoverColor
            symbol.color = textColor
            alpKey.entered = true
        }

        onExited: {
            if (!alpKey.hold){
                alpKey.color = keyColor
                symbol.color = textColor
            }
            alpKey.entered = false
        }

        onPressed: {
            alpKey.color = keyPressedColor
            symbol.color = textPressedColor
            console.log(symbol.text)

        }
        onPressAndHold: {
            alpKey.color = keyPressedColor
            symbol.color = textPressedColor
            alpKey.hold = true
            console.log(alpKey.hold);

        }
        onReleased: {
            alpKey.color = hoveredChanged() ? keyColor : keyHoverColor
            symbol.color = textColor
            alpKey.hold = false
            if (!alpKey.entered){
                alpKey.color = keyColor
                symbol.color = textColor
            }

        }
    }
}
