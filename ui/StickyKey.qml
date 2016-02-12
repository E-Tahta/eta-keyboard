import QtQuick 2.3

// StickyKey

Key {
    id: key
    leVis4: true

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
