import QtQuick 2.0

Rectangle {

    id: arwKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth : main.keyWidth
    property int keyHeight: main.keyHeight
    property int fontPointSize: 10


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10

    property bool hold: false
    property bool entered: false
    Text {
        id: symbol
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            centerIn: arwKey
        }
        text: keySymbolLevel1
    }

    signal clickedArrow(string btnCode)

    function btnClicked(){

    }

    function btnPressed(){
        arwKey.color = arwKey.keyPressedColor
        symbol.color = arwKey.textPressedColor
    }

    function btnHovered(){
        if (!arwKey.hold){
            if (arwKey.entered){
                arwKey.color = arwKey.keyHoverColor
                symbol.color = arwKey.textColor
            }

            else {

                arwKey.color = arwKey.keyColor
                symbol.color = arwKey.textColor

            }
        }
    }

    function btnHold(){
        arwKey.hold = true

        arwKey.color = arwKey.keyPressedColor
        symbol.color = arwKey.textPressedColor
    }

    function btnReleased(){
        arwKey.hold = false
        btnHovered()
    }




    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            arwKey.entered = true
            btnHovered()
        }

        onExited: {
            arwKey.entered = false
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
            arwKey.btnClicked()
        }
    }

}
