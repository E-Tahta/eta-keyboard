import QtQuick 2.0

Rectangle {
    id: alpKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property int keyLevel: main.keyLevel
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight

    property int keyCode: 24
    property int fontPointSize: 10

    property bool isLevel2Visible: false
    property bool isLevel3Visible: false


    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10

    property bool hold: false
    property bool entered: false



    onKeyLevelChanged: {
        switch (main.keyLevel){
        case 0:
            symbol2.color = main.textColor
            symbol3.color = main.textColor
            break;
        case 2:
            symbol2.color = "red"
            symbol3.color = main.textColor
            break;
        case 1:
            symbol2.color = main.textColor
            symbol3.color = "red"
            break;
        case 3:
            symbol2.color = main.textColor
            symbol3.color = main.textColor

        }
    }



    Text {
        id: symbol
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            left: alpKey.left
            top: alpKey.top
            margins: keyHeight/10
        }
        text: helper.getSymbol(alpKey.keyCode,main.languageLayoutIndex,1)
    }
    Text {
        id: symbol2
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            right: alpKey.right
            bottom: alpKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(alpKey.keyCode,main.languageLayoutIndex,2)
        visible: alpKey.isLevel2Visible


    }

    Text {
        id: symbol3
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            right: alpKey.right
            bottom: alpKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(alpKey.keyCode,main.languageLayoutIndex,3)
        visible: alpKey.isLevel3Visible


    }


    //signal clickedAlpha(string btnCode)

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
