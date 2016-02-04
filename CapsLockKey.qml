import QtQuick 2.0
import eta.helper 1.0

Rectangle {

    id: capsKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth
    property int keyHeight: main.keyHeight
    property int fontPointSize: 9

    property bool hold: false
    property bool entered: false
    property bool clickedFlag: false

    property int keyCode: 66

    property string activeLedColor: "light green"
    property string passiveLedColor: main.keyColor


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10


    Rectangle {
        id: statusLed
        width: keyWidth / 9
        height: statusLed.width
        radius: height / 2
        border.color: main.textColor

        anchors {
            top : capsKey.top
            right: capsKey.right
            margins: statusLed.width / 2
        }

        color: capsKey.clickedFlag ? capsKey.activeLedColor : capsKey.passiveLedColor

    }



    Text {
        id: symbol
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            centerIn: capsKey
        }
        text: keySymbolLevel1
    }


    function btnHoveredEffect(){
        if (!capsKey.hold){
            if (capsKey.entered){
                capsKey.color = capsKey.keyHoverColor
                symbol.color = capsKey.textColor

            }

            else {

                capsKey.color = capsKey.keyColor
                symbol.color = capsKey.textColor

            }
        }
    }

    function btnHold(){
        capsKey.hold = true
        capsKey.color = capsKey.keyPressedColor
        symbol.color = capsKey.textPressedColor
    }



    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            capsKey.entered = true
            btnHoveredEffect()
        }

        onExited: {
            capsKey.entered = false
            btnHoveredEffect()
        }

        onPressed: {
            helper.fakeKeyPress(66)
            capsKey.color = capsKey.keyPressedColor
            symbol.color = capsKey.textPressedColor

        }
        onPressAndHold: {
            btnHold()

        }
        onReleased: {
            capsKey.hold = false
            helper.fakeKeyRelease(66);
            btnHoveredEffect()

        }
        onClicked: {

        }
    }

    Timer {
        running: true
        repeat: true
        interval: 5
        onTriggered: {
            capsKey.clickedFlag = helper.getCapslockStatus();

        }
    }

}
