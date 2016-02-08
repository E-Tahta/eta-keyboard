import QtQuick 2.0

Rectangle {

    id: numKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string activeTextColor: main.activeTextColor
    property string textPressedColor: main.textPressedColor

    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight
    property int fontPointSize: 11

    property bool hold: false
    property bool entered: false

    property int keyLevel: main.keyLevel

    property int keyCode: 24

    property double activeOpacity: 1
    property double passiveOpacity: 0.2

    property bool leVis0: true
    property bool leVis1: true
    property bool leVis2: true



    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10



    onKeyLevelChanged: {
        switch (main.keyLevel){
        case 0:
            lev0.color = numKey.activeTextColor
            lev1.color = numKey.textColor
            lev2.color = numKey.textColor
            lev0.opacity = numKey.activeOpacity
            lev1.opacity = numKey.passiveOpacity
            lev2.opacity = numKey.passiveOpacity
            break;
        case 1:
            lev0.color = numKey.textColor
            lev1.color = numKey.activeTextColor
            lev2.color = numKey.textColor
            lev0.opacity = numKey.passiveOpacity
            lev1.opacity = numKey.activeOpacity
            lev2.opacity = numKey.passiveOpacity
            break;
        case 2:
            lev0.color = numKey.textColor
            lev1.color = numKey.textColor
            lev2.color = "light green"
            lev0.opacity = numKey.passiveOpacity
            lev1.opacity = numKey.passiveOpacity
            lev2.opacity = numKey.activeOpacity
            //leVis2 = true
            break;
        case 3:
            lev0.color = numKey.textColor
            lev1.color = numKey.textColor
            lev2.color = numKey.activeTextColor
            lev0.opacity = numKey.passiveOpacity
            lev1.opacity = numKey.passiveOpacity
            lev2.opacity = numKey.passiveOpacity

        }
    }

    Text {
        id: lev0
        color: activeTextColor
        font.pointSize: fontPointSize
        anchors {
            left: numKey.left
            bottom: numKey.bottom
            margins: keyHeight/7
        }
        text: helper.getSymbol(numKey.keyCode,main.languageLayoutIndex,0)
        visible: leVis0
        opacity: activeOpacity
    }

    Text {
        id: lev1
        color: textColor
        font.pointSize:fontPointSize
        anchors {
            left: numKey.left
            top: numKey.top
            margins: keyHeight/10
        }
        text:helper.getSymbol(numKey.keyCode,main.languageLayoutIndex,1)
        visible: leVis1
        opacity: passiveOpacity
    }

    Text {
        id: lev2
        color: textColor
        font.pointSize: fontPointSize
        anchors {
            right: numKey.right
            bottom: numKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(numKey.keyCode,main.languageLayoutIndex,2)
        visible: leVis2
        opacity: passiveOpacity
    }


    signal clickedNumeric(string btnCode)



    function btnClicked(){
    }

    function btnPressed(){
        numKey.color = numKey.keyPressedColor
        switch (numKey.keyLevel){
        case 0: lev0.color = numKey.textPressedColor; break;
        case 1: lev1.color = numKey.textPressedColor; break;
        case 2: lev2.color = numKey.textPressedColor; break;
        }

        main.nonStickyPressed(numKey.keyCode)
    }

    function btnHovered(){
        if (!numKey.hold){
            if (numKey.entered){
                numKey.color = numKey.keyHoverColor
                lev0.color = numKey.textColor
                lev1.color = numKey.textColor
                lev2.color = numKey.textColor
            }

            else {
                numKey.color = numKey.keyColor
                lev0.color = numKey.textColor
                lev1.color = numKey.textColor
                lev2.color = numKey.textColor
            }
        }
    }

    function btnHold(){
        numKey.hold = true
    }

    function btnReleased(){
        numKey.hold = false
        btnHovered()
        main.nonStickyReleased(numKey.keyCode)
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
