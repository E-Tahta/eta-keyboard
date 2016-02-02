import QtQuick 2.0

Rectangle {

    id: sticKey

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
    property bool clickedFlag: false

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
            centerIn: sticKey
        }
        text: keySymbolLevel1
    }



    function btnClicked(){

        sticKey.clickedFlag = !clickedFlag;

        if (sticKey.clickedFlag){
            btnPressed()
             main.stickyKeyPressed(sticKey.keyCode)
            //console.log(sticKey.keyCode)
        }

        else {
            btnHovered()
            main.stickyKeyReleased(sticKey.keyCode)
        }

    }

    function releaseBtn(){
        if (sticKey.clickedFlag)
            btnClicked()
    }


    function btnPressed(){
        sticKey.color = sticKey.keyPressedColor
        symbol.color = sticKey.textPressedColor

    }

    function btnHovered(){
        if (!sticKey.hold && !sticKey.clickedFlag){
            if (sticKey.entered){
                sticKey.color = sticKey.keyHoverColor
                symbol.color = sticKey.textColor
            }

            else {

                sticKey.color = sticKey.keyColor
                symbol.color = sticKey.textColor

            }
        }
    }

    function btnHold(){
        sticKey.clickedFlag = false
        sticKey.hold = true

        sticKey.color = sticKey.keyPressedColor
        symbol.color = sticKey.textPressedColor
    }

    function btnReleased(){
        sticKey.hold = false
        if (!sticKey.clickedFlag)
        btnHovered()
    }



    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            sticKey.entered = true
            btnHovered()
        }

        onExited: {
            sticKey.entered = false
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
            sticKey.btnClicked()
        }
    }

}
