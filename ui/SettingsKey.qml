import QtQuick 2.3

// SettingsKey

Key {
    id: key
    property int angle: 90

    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: "Images/gear.png"


        RotationAnimation on rotation {
            id: rotationAnimation
            from: 0 + key.angle
            to: 90 - key.angle
            duration: 300
            easing.type:  Easing.OutQuad

        }
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
            if (!main.settingsVisible){
                key.angle = 90
                main.settingsVisible = true
            }
            else{
                key.angle = 0
                main.settingsVisible = false

            }
            rotationAnimation.start()
        }
    }
}
