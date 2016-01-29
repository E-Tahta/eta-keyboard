import QtQuick 2.0

Rectangle {

    id: specKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property string keySymbolLevel2
    property string keySymbolLevel3
    property int keyWidth
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
            centerIn: specKey
        }
        text: keySymbolLevel1
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            specKey.color = keyHoverColor
            symbol.color = textColor
            specKey.entered = true
        }

        onExited: {
            if (!specKey.hold){
                specKey.color = keyColor
                symbol.color = textColor
            }
            specKey.entered = false
        }

        onPressed: {
            specKey.color = keyPressedColor
            symbol.color = textPressedColor
            console.log(symbol.text)

        }
        onPressAndHold: {
            specKey.color = keyPressedColor
            symbol.color = textPressedColor
            specKey.hold = true
            console.log(specKey.hold);

        }
        onReleased: {
            specKey.color = hoveredChanged() ? keyColor : keyHoverColor
            symbol.color = textColor
            specKey.hold = false
            if (!specKey.entered){
                specKey.color = keyColor
                symbol.color = textColor
            }

        }
    }
}
