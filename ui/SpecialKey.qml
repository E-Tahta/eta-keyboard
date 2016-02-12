import QtQuick 2.0

// SpecialKey

Key {
    id: key
    leVis4: true

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
