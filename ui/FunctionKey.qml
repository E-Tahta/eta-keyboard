import QtQuick 2.3

// FunctionKey

Key {
    id: key
    leVis4: true
    keyHeight: main.keyHeight / 2
    keyWidth: (15 * main.keyWidth - 3 * main.spacing ) / 18

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
            main.nonStickyPressed(key.keyCode)
        }
        onPressAndHold: {
            btnHold()
        }
        onReleased: {
            btnReleased()
            main.nonStickyReleased(key.keyCode)
        }
        onClicked: {
            btnClicked()
        }
    }
}
