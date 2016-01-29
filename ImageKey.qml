import QtQuick 2.0

Rectangle {

    id: imgKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string imgSource
    property bool isAnimated: false
    property int keyWidth
    property int keyHeight: main.keyHeight

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
        source: imgKey.imgSource


        RotationAnimation on rotation {
            onStarted: {
                if (imgKey.open)
                    imgKey.angle = 90;
                else
                    imgKey.angle = 0
                imgKey.open = !imgKey.open;
            }
            id: rotationAnimation
            from: 0 + imgKey.angle
            to: 90 - imgKey.angle
            duration: 500
            easing.type: Easing.OutBounce
        }
    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            imgKey.color = keyHoverColor
            imgKey.entered = true
        }

        onExited: {
            if (!imgKey.hold){
                imgKey.color = keyColor

            }
            imgKey.entered = false
        }

        onPressed: {
            imgKey.color = keyPressedColor

            console.log(imgSource)

        }
        onPressAndHold: {
            imgKey.color = keyPressedColor

            imgKey.hold = true
            console.log(imgKey.hold);

        }
        onReleased: {
            imgKey.color = hoveredChanged() ? keyColor : keyHoverColor

            imgKey.hold = false
            if (!imgKey.entered){
                imgKey.color = keyColor
            }

        }
        onClicked: if(imgKey.isAnimated)rotationAnimation.start()
    }
}
