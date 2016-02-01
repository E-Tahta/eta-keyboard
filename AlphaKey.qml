import QtQuick 2.0

Rectangle {
    id: alpKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property string keySymbolLevel2
    property string keySymbolLevel3
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10

    property bool hold: false
    property bool entered: false
    Text {
        id: symbol
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            left: alpKey.left
            top: alpKey.top
            margins: keyHeight/10
        }
        text: keySymbolLevel1
    }
    Text {
        id: symbol2
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            left: alpKey.left
            bottom: alpKey.bottom
            margins: keyHeight/10
        }
        text: keySymbolLevel2
    }
    Text {
        id: symbol3
        color: textColor
        font.pointSize: keyHeight * 3 / 12
        anchors {
            right: alpKey.right
            bottom: alpKey.bottom
            margins: keyHeight/10
        }
        text: keySymbolLevel3
    }

    signal clickedAlpha(string btnCode)

    function btnClicked(){

    }

    function btnPressed(){
        alpKey.color = alpKey.keyPressedColor
        symbol.color = alpKey.textPressedColor
    }

    function btnHovered(){
        if (!alpKey.hold){
            if (alpKey.entered){
                alpKey.color = alpKey.keyHoverColor
                symbol.color = alpKey.textColor
            }

            else {

                alpKey.color = alpKey.keyColor
                symbol.color = alpKey.textColor

            }
        }
    }

    function btnHold(){
        alpKey.hold = true

        alpKey.color = alpKey.keyPressedColor
        symbol.color = alpKey.textPressedColor
    }

    function btnReleased(){
        alpKey.hold = false
        btnHovered()
    }




    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            alpKey.entered = true
            btnHovered()
        }

        onExited: {
            alpKey.entered = false
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
            alpKey.btnClicked()
        }
    }

}
