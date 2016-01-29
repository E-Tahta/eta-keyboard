import QtQuick 2.0

Rectangle {

    id: setKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property int keyHeight: main.keyHeight
    property int keyWidth: main.keyWidth

    property bool open: false
    property int angle: 90


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10

    property bool hold: false
    property bool entered: false
    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: "Images/gear.png"


        RotationAnimation on rotation {
            onStarted: {
                if (setKey.open)
                    setKey.angle = 0;
                else
                    setKey.angle = 90
                setKey.open = !setKey.open;
            }
            id: rotationAnimation
            from: 0 + setKey.angle
            to: 90 - setKey.angle
            duration: 500
            easing.type: Easing.OutBounce
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (!setKey.hold){
                setKey.color = setKey.keyHoverColor


            }
            setKey.entered = true
        }

        onExited: {
            if (!setKey.hold){
                setKey.color = setKey.keyColor

            }
            setKey.entered = false
        }

        onPressed: {
            setKey.color = setKey.keyPressedColor




        }
        onPressAndHold: {
            setKey.color = setKey.keyPressedColor

            setKey.hold = true


        }
        onReleased: {
            setKey.hold = false
            if (!setKey.entered){
                setKey.color = setKey.keyColor

            }
            else {
                setKey.color = setKey.keyHoverColor

            }

        }
         onClicked: rotationAnimation.start();
    }
}
