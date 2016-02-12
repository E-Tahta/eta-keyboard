import QtQuick 2.0

// FunctionKey

Key {
    id: key
    leVis4: true
    keyHeight: main.keyHeight / 2
    keyWidth: main.keyWidth * 41 / 50

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
