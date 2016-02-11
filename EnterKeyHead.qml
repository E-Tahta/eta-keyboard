import QtQuick 2.0

// EnterKeyHead

Key {
    id: key
    leVis4: true
    keyCode: 36
    keyText: "\u23CE Enter"

    width: main.keyWidth * 8 / 5
    height: main.keyHeight * 2 + main.columnSpacing

    Rectangle{
        width:  main.keyWidth * 3 / 10
        height: main.keyHeight + main.columnSpacing
        color: main.color
        radius: key.keyRadius
        anchors{
            bottom: key.bottom
            left: key.left
        }
    }
}
