import QtQuick 2.0

Rectangle {
    id: funcKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth: main.keyWidth * 49 / 60
    property int keyHeight: main.keyHeight / 2
    property int fontPointSize: 8

    property int keyCode: 24


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/5

    property bool hold: false
    property bool entered: false



    Text {
        id: symbol
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            left: funcKey.left
            top: funcKey.top
            margins: keyHeight/10
        }
        text: keySymbolLevel1
    }

    signal clickedFunction(string btnCode)

    function btnClicked(){



    }

    function btnPressed(){
        funcKey.color = funcKey.keyPressedColor
        symbol.color = funcKey.textPressedColor
        main.nonStickyPressed(funcKey.keyCode)
    }

    function btnHovered(){
        if (!funcKey.hold){
            if (funcKey.entered){
                funcKey.color = funcKey.keyHoverColor
                symbol.color = funcKey.textColor
            }

            else {

                funcKey.color = funcKey.keyColor
                symbol.color = funcKey.textColor

            }
        }
    }

    function btnHold(){
        funcKey.hold = true

        funcKey.color = funcKey.keyPressedColor
        symbol.color = funcKey.textPressedColor
    }

    function btnReleased(){
        funcKey.hold = false
        btnHovered()
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
