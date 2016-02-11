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
        }
        onPressAndHold: {
            btnHold()
        }
        onReleased: {
            btnReleased()
        }
        onClicked: {
            btnClicked()
        }
    }
}
