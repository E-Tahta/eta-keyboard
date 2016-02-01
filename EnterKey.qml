import QtQuick 2.0
Item {


    id: entKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight

    property bool hold: false
    property bool entered: false

    width: keyWidth * 8 / 5
    height: keyHeight * 2 + main.columnSpacing

    Rectangle{
        id: head
        color: entKey.keyColor
        radius: entKey.keyHeight/10

        height: entKey.keyHeight
        width: entKey.width
        z: 1

        Text {
            id: symbol
            color: textColor
            font.pointSize: entKey.keyHeight * 3 / 15
            anchors {
                centerIn: head
            }
            text: "\u23CE Enter"
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                if (!entKey.hold){
                    head.color = entKey.keyHoverColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyHoverColor

                }
                entKey.entered = true
            }

            onExited: {
                if (!entKey.hold){
                    head.color = entKey.keyColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyColor

                }
                entKey.entered = false
            }

            onPressed: {
                head.color = entKey.keyPressedColor
                symbol.color = entKey.textPressedColor
                foot.color = entKey.keyPressedColor



            }
            onPressAndHold: {
                head.color = entKey.keyPressedColor
                symbol.color = entKey.textPressedColor
                foot.color = entKey.keyPressedColor

                entKey.hold = true

            }
            onReleased: {
                entKey.hold = false
                if (!entKey.entered){
                    head.color = entKey.keyColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyColor

                }
                else {
                    head.color = entKey.keyHoverColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyHoverColor

                }

            }
        }
    }

    Rectangle{
        id: foot
        color: entKey.keyColor
        radius: entKey.keyHeight/10

        z: 0

        width: entKey.keyWidth * 13 / 10
        height: entKey.height

        anchors {
            top: head.top
            right: head.right
        }


        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                if (!entKey.hold){
                    head.color = entKey.keyHoverColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyHoverColor

                }
                entKey.entered = true
            }

            onExited: {
                if (!entKey.hold){
                    head.color = entKey.keyColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyColor

                }
                entKey.entered = false
            }

            onPressed: {
                head.color = entKey.keyPressedColor
                symbol.color = entKey.textPressedColor
                foot.color = entKey.keyPressedColor

               main.nonStickyPressed(symbol.text)

            }
            onPressAndHold: {
                head.color = entKey.keyPressedColor
                symbol.color = entKey.textPressedColor
                foot.color = entKey.keyPressedColor

                entKey.hold = true

            }
            onReleased: {
                entKey.hold = false
                if (!entKey.entered){
                    head.color = entKey.keyColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyColor

                }
                else {
                    head.color = entKey.keyHoverColor
                    symbol.color = entKey.textColor
                    foot.color = entKey.keyHoverColor

                }

            }
        }
    }


}
