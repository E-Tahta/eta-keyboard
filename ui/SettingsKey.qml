import QtQuick 2.3

// SettingsKey

Key {
    id: key
    property bool open: main.settingsVisible
    property int angle: 90

    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: "Images/gear.png"


        RotationAnimation on rotation {
            onStarted: {
                if (!key.open)
                    key.angle = 0;
                else
                    key.angle = 90
                key.open = !key.open;
                main.settingsVisible = !main.settingsVisible
            }
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
            rotationAnimation.start()
        }
    }
}
