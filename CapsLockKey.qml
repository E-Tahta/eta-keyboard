import QtQuick 2.0

// FunctionKey

Key {
    id: key

    property string activeLedColor: "light green"
    property string passiveLedColor: main.keyColor

    property bool clickedFlag: false


    leVis4: true

    keyCode: 66

    Rectangle {
        id: statusLed
        width: keyWidth / 9
        height: statusLed.width
        radius: height / 2
        border.color: main.textColor

        anchors {
            top : key.top
            right: key.right
            margins: statusLed.width / 2
        }

        color: key.clickedFlag ? key.activeLedColor : key.passiveLedColor

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
            helper.fakeKeyPress(66)
        }
        onPressAndHold: {
            btnHold()
        }
        onReleased: {
            btnReleased()
            helper.fakeKeyRelease(66);
        }
        onClicked: {
            btnClicked()
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 5
        onTriggered: {
            key.clickedFlag = helper.getCapslockStatus();

        }
    }

}
