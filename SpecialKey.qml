import QtQuick 2.0

Rectangle {

    id: specKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth
    property int keyHeight: main.keyHeight
    property int fontPointSize: 10
    property bool hold: false
    property bool entered: false

    property int keyCode: 24


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10


    Text {
        id: symbol
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            centerIn: specKey
        }
        text: keySymbolLevel1
    }


    signal clickedSpecial(string btnCode)

    function btnClicked(){




    }

    function btnPressed(){
        specKey.color = specKey.keyPressedColor
        symbol.color = specKey.textPressedColor

          main.nonStickyPressed(specKey.keyCode)
    }

    function btnHovered(){
        if (!specKey.hold){
            if (specKey.entered){
                specKey.color = specKey.keyHoverColor
                symbol.color = specKey.textColor
            }

            else {

                specKey.color = specKey.keyColor
                symbol.color = specKey.textColor

            }
        }
    }

    function btnHold(){
        specKey.hold = true

        specKey.color = specKey.keyPressedColor
        symbol.color = specKey.textPressedColor
    }

    function btnReleased(){
        specKey.hold = false
        btnHovered()
    }




    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            specKey.entered = true
            btnHovered()
        }

        onExited: {
            specKey.entered = false
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
            specKey.btnClicked()
        }
    }

}
