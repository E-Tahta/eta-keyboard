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
    property bool clickedFlag: false

    property int keyCode: 24

    Image {
        id: img
        width: parent.width * 2 / 3
        height: img.width
        anchors.centerIn: parent
        source: "Images/pardus.png"
    }


    function btnClicked(){
    }

    function releaseBtn(){

        metKey.clickedFlag = false

    }


    function btnPressed(){
        metKey.clickedFlag = !metKey.clickedFlag
        if (metKey.clickedFlag)
        main.stickyKeyPressed(keyCode)


    }

    function btnReleased(){
        metKey.hold = false
        if (!metKey.clickedFlag)
        main.stickyKeyReleased(keyCode)
    }


    function btnHovered(){
        if (!metKey.hold && !metKey.clickedFlag){
            if (metKey.entered){
                metKey.color = metKey.keyHoverColor

            }

            else {

                metKey.color = metKey.keyColor

            }
        }
    }

    function btnHold(){

        metKey.hold = true
    }




    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            metKey.entered = true
            btnHovered()
        }

        onExited: {
            metKey.entered = false
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
            metKey.btnClicked()
        }
    }

    onClickedFlagChanged: {
        if (clickedFlag){
            metKey.color = metKey.keyPressedColor

        }
        else {
            btnHovered()
        }
    }

}
