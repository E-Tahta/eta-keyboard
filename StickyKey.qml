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

    property bool hold: false
    property bool entered: false
    property bool clickedFlag: false

    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10

    signal clickedSticky(string btnCode)

    function clickBtn(){

        sticKey.clickedFlag = !clickedFlag;

        if (sticKey.clickedFlag){
            sticKey.color = sticKey.keyPressedColor;
            symbol.color = sticKey.textPressedColor;
            clickedSticky(sticKey.keySymbolLevel1);
        }

        else {

            sticKey.color = sticKey.keyColor
            symbol.color = sticKey.textColor
        }




    }

    function releaseBtn(){
        if (sticKey.clickedFlag)
            clickBtn()
    }

    Text {
        id: symbol
        color: textColor
        font.pointSize: keyHeight * 3 / 15
        anchors {
            centerIn: sticKey
        }
        text: keySymbolLevel1
    }

    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            if (!sticKey.hold && !sticKey.clickedFlag){
                sticKey.color = sticKey.keyHoverColor
                symbol.color = sticKey.textColor


            }
            sticKey.entered = true
        }

        onExited: {
            if (!sticKey.hold && !sticKey.clickedFlag){
                sticKey.color = sticKey.keyColor
                symbol.color = sticKey.textColor


            }
            sticKey.entered = false
        }

        onPressed: {
            sticKey.color = sticKey.keyPressedColor
            symbol.color = sticKey.textPressedColor

            if (!sticKey.clickedFlag);
                //console.log(symbol.text)

        }
        onPressAndHold: {
            sticKey.color = sticKey.keyPressedColor

            symbol.color = sticKey.textPressedColor

            sticKey.clickedFlag = false
            sticKey.hold = true
            //console.log(sticKey.hold);

        }
        onReleased: {
            sticKey.hold = false
            if (!sticKey.entered){
                sticKey.color = sticKey.keyColor
                symbol.color = sticKey.textColor


            }
            else {
                sticKey.color = sticKey.keyHoverColor
                symbol.color = sticKey.textColor


            }

        }
        onClicked: {

            sticKey.clickBtn()



        }

    }

}
