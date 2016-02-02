import QtQuick 2.0

Rectangle {

    id: numKey

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
    property int fontPointSize: 10

    property bool hold: false
    property bool entered: false

    property int keyLevel: main.keyLevel

    property int keyCode: 24

    property bool isLevel3Visible: true



    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10



    onKeyLevelChanged: {
        switch (main.keyLevel){
        case 0:
            symbol2.color = main.textColor
            symbol3.color = main.textColor
            break;
        case 1:
            symbol2.color = "red"
            symbol3.color = main.textColor
            break;
        case 2:
            symbol2.color = main.textColor
            symbol3.color = "red"
            break;
        case 3:
            symbol2.color = main.textColor
            symbol3.color = main.textColor

        }

        //console.log("catch")
    }




    Text {
        id: symbol
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            left: numKey.left
            bottom: numKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(numKey.keyCode,main.languageLayoutIndex,0)
    }

    Text {
        id: symbol2
        color: textColor
        font.pointSize:fontPointSize
        anchors {
            left: numKey.left
            top: numKey.top
            margins: keyHeight/10
        }
        text:helper.getSymbol(numKey.keyCode,main.languageLayoutIndex,1)
    }

    Text {
        id: symbol3
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            right: numKey.right
            bottom: numKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(numKey.keyCode,main.languageLayoutIndex,2)
        visible: isLevel3Visible
    }


    signal clickedNumeric(string btnCode)

    function btnClicked(){

    }

    function btnPressed(){
        numKey.color = numKey.keyPressedColor
        symbol.color = numKey.textPressedColor
    }

    function btnHovered(){
        if (!numKey.hold){
            if (numKey.entered){
                numKey.color = numKey.keyHoverColor
                symbol.color = numKey.textColor
            }

            else {

                numKey.color = numKey.keyColor
                symbol.color = numKey.textColor

            }
        }
    }

    function btnHold(){
        numKey.hold = true

        numKey.color = numKey.keyPressedColor
        symbol.color = numKey.textPressedColor
    }

    function btnReleased(){
        numKey.hold = false
        btnHovered()
    }




    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            numKey.entered = true
            btnHovered()
        }

        onExited: {
            numKey.entered = false
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
            numKey.btnClicked()
        }
    }

}
