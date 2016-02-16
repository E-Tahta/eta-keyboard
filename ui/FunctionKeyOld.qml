import QtQuick 2.3

Rectangle {
    id: funcKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string activeTextColor: main.activeTextColor
    property string textPressedColor: main.textPressedColor
    property double keyWidth: main.keyWidth * 41/50
    property int keyHeight: main.keyHeight/2
    property int keyCode: 24
    property int fontPointSize: 8

    property bool hold: false
    property bool entered: false

    property int keyLevel: main.keyLevel
    property string keyText


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/5



    Text {
        id: lev0
        color: activeTextColor
        font.pointSize: fontPointSize
        anchors {
            centerIn: parent
        }
        text:funcKey.keyText

    }


    function btnClicked(){
    }

    function btnPressed(){
        funcKey.color = funcKey.keyPressedColor
        lev0.color = funcKey.textPressedColor

        main.nonStickyPressed(funcKey.keyCode)
    }

    function btnHovered(){
        if (!funcKey.hold){
            if (funcKey.entered){
                funcKey.color = funcKey.keyHoverColor
                lev0.color = funcKey.textColor

            }

            else {
                funcKey.color = funcKey.keyColor
                lev0.color = funcKey.textColor

            }
        }
    }

    function btnHold(){
        funcKey.hold = true
    }

    function btnReleased(){
        funcKey.hold = false
        btnHovered()

        main.nonStickyReleased(funcKey.keyCode)

    }


    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            funcKey.entered = true
            btnHovered()
        }

        onExited: {
            funcKey.entered = false
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
            funcKey.btnClicked()
        }
    }

}
