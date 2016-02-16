import QtQuick 2.3

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
                main.settingsVisible = !main.settingsVisible
            }
            id: rotationAnimation
            from: 0 + setKey.angle
            to: 90 - setKey.angle
            duration: 500
            easing.type: Easing.OutBounce



        }
    }

    signal clickedMeta(string btnCode)

    function btnClicked(){
        rotationAnimation.start()

    }


    function btnPressed(){
        setKey.color = setKey.keyPressedColor

    }

    function btnHovered(){
        if (!setKey.hold){
            if (setKey.entered){
                setKey.color = setKey.keyHoverColor
            }

            else {
                setKey.color = setKey.keyColor
            }
        }
    }

    function btnHold(){
        setKey.hold = true

        setKey.color = setKey.keyPressedColor
    }

    function btnReleased(){
        setKey.hold = false
        btnHovered()
    }



    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            setKey.entered = true
            btnHovered()
        }

        onExited: {
            setKey.entered = false
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
            setKey.btnClicked()
        }
    }
}
