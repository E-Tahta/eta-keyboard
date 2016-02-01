import QtQuick 2.0

Rectangle {

    id: metKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight

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
        source: "Images/pardus.png"

    }

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (!metKey.hold){
                metKey.color = metKey.keyHoverColor


            }
            metKey.entered = true
        }

        onExited: {
            if (!metKey.hold){
                metKey.color = metKey.keyColor


            }
            metKey.entered = false
        }

        onPressed: {
            metKey.color = metKey.keyPressedColor



        }
        onPressAndHold: {
            metKey.color = metKey.keyPressedColor



            metKey.hold = true


        }
        onReleased: {
            metKey.hold = false
            if (!metKey.entered){
                metKey.color = metKey.keyColor



            }
            else {
                metKey.color = metKey.keyHoverColor



            }

        }

    }
}
