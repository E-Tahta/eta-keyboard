import QtQuick 2.0

Rectangle {
    id: alpNumKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight
    property int keyCode: 24
    property int fontPointSize: 10

    property bool hold: false
    property bool entered: false

    property int keyLevel: main.keyLevel

    property bool leVis0: false
    property bool leVis1: false
    property bool leVis2: false




    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10




    onKeyLevelChanged: {
        switch (main.keyLevel){
        case 0:
            lev1.color = alpNumKey.textColor
            lev2.color = alpNumKey.textColor
            break;
        case 1:
            lev1.color = "red"
            lev2.color = alpNumKey.textColor
            break;
        case 2:
            lev1.color = alpNumKey.textColor
            lev2.color = "red"
            break;
        case 3:
            lev1.color = alpNumKey.textColor
            lev2.color = alpNumKey.textColor

        }
    }


    Text {
        id: lev0
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            left: alpNumKey.left
            bottom: alpNumKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(alpNumKey.keyCode,main.languageLayoutIndex,0)
        visible: leVis0
    }

    Text {
        id: lev1
        color: textColor
        font.pointSize:fontPointSize
        anchors {
            left: alpNumKey.left
            top: alpNumKey.top
            margins: keyHeight/10
        }
        text:helper.getSymbol(alpNumKey.keyCode,main.languageLayoutIndex,1)
        visible: leVis1
    }

    Text {
        id: lev2
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            right: alpNumKey.right
            bottom: alpNumKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(alpNumKey.keyCode,main.languageLayoutIndex,2)
        visible: leVis2
    }

    function btnClicked(){
    }

    function btnPressed(){
        alpNumKey.color = alpNumKey.keyPressedColor
        lev0.color = alpNumKey.textPressedColor
        main.nonStickyPressed(alpNumKey.keyCode)
    }

    function btnHovered(){
        if (!alpNumKey.hold){
            if (alpNumKey.entered){
                alpNumKey.color = alpNumKey.keyHoverColor
                lev0.color = alpNumKey.textColor
            }

            else {
                alpNumKey.color = alpNumKey.keyColor
                lev0.color = alpNumKey.textColor
            }
        }
    }

    function btnHold(){
        alpNumKey.hold = true

        alpNumKey.color = alpNumKey.keyPressedColor
        lev0.color = alpNumKey.textPressedColor
    }

    function btnReleased(){
        alpNumKey.hold = false
        btnHovered()
    }




    MouseArea{
        id: ma
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            alpNumKey.entered = true
            btnHovered()
        }

        onExited: {
            alpNumKey.entered = false
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
            alpNumKey.btnClicked()
        }
    }

    Component.onCompleted: {
        if (helper.getSymbol(alpNumKey.keyCode,main.languageLayoutIndex,0)>="a" && helper.getSymbol(alpNumKey.keyCode,main.languageLayoutIndex,0)<="z"){
            leVis1 = true

            console.log(alpNumKey.keyCode)

        }
        else {
            leVis0 = true
            leVis1 = true
            leVis2 = true
        }

    }

}
