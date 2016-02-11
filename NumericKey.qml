import QtQuick 2.0

// NumericKey

Key {
    id: key
    leVis0: true
    leVis1: true
    leVis2: true

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
            key.btnClicked()
        }
    }
}
