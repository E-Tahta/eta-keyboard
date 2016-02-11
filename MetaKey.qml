import QtQuick 2.0

// MetaKey

Key {
    id: key

    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: "Images/pardus.png"
    }

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
