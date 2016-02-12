import QtQuick 2.0

// MetaKey

Key {
    id: key

    function stickyPressed() {
        key.lock = true
        btnPressed()

        main.stickyKeyPressed(key.keyCode)

    }

    function stickyReleased(){
        key.lock = false
        btnHovered()

        main.stickyKeyReleased(key.keyCode)
    }

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

        onPressed: {
            if (!key.lock)
                stickyPressed()
            else stickyReleased()
        }
        onPressAndHold: {
            btnHold()
        }
        onReleased: {
            key.hold = false

        }
        onClicked: {
            btnClicked()
        }
    }
}
