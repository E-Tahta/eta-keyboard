import QtQuick 2.0

Rectangle {
    id: alpNumKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string activeTextColor: main.activeTextColor
    property string textPressedColor: main.textPressedColor
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight
    property int keyCode: 24
    property int fontPointSize: 11

    property bool hold: false
    property bool entered: false

    property int keyLevel: main.keyLevel

    property bool leVis0: true
    property bool leVis1: true
    property bool leVis2: false

    property double activeOpacity: 1
    property double passiveOpacity: 0.2





    width: keyWidth
    height: keyHeight
    color: keyColor
    radius: keyHeight/10




    onKeyLevelChanged: {
        switch (main.keyLevel){
        case 0:
            lev0.color = alpNumKey.activeTextColor
            lev1.color = alpNumKey.textColor
            lev2.color = alpNumKey.textColor
            lev0.opacity = alpNumKey.activeOpacity
            lev1.opacity = alpNumKey.passiveOpacity
            lev2.opacity = alpNumKey.passiveOpacity
            break;
        case 1:
            lev0.color = alpNumKey.textColor
            lev1.color = alpNumKey.activeTextColor
            lev2.color = alpNumKey.textColor
            lev0.opacity = alpNumKey.passiveOpacity
            lev1.opacity = alpNumKey.activeOpacity
            lev2.opacity = alpNumKey.passiveOpacity
            break;
        case 2:
            lev0.color = alpNumKey.textColor
            lev1.color = alpNumKey.textColor
            lev2.color = "light green"
            lev0.opacity = alpNumKey.passiveOpacity
            lev1.opacity = alpNumKey.passiveOpacity
            lev2.opacity = alpNumKey.activeOpacity
            //leVis2 = true
            break;
        case 3:
            lev0.color = alpNumKey.textColor
            lev1.color = alpNumKey.textColor
            lev2.color = alpNumKey.activeTextColor
            lev0.opacity = alpNumKey.passiveOpacity
            lev1.opacity = alpNumKey.passiveOpacity
            lev2.opacity = alpNumKey.passiveOpacity

        }
    }


    Text {
        id: lev0
        color: activeTextColor
        font.pointSize: fontPointSize
        anchors {
            left: alpNumKey.left
            bottom: alpNumKey.bottom
            margins: keyHeight/10
        }
        text: helper.getSymbol(alpNumKey.keyCode,main.languageLayoutIndex,0)
        visible: leVis0
        opacity: activeOpacity
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
        opacity: passiveOpacity
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
        opacity: passiveOpacity
    }

    function btnClicked(){
    }

    function btnPressed(){
        alpNumKey.color = alpNumKey.keyPressedColor
        switch (alpNumKey.keyLevel){
        case 0: lev0.color = alpNumKey.textPressedColor; break;
        case 1: lev1.color = alpNumKey.textPressedColor; break;
        case 2: lev2.color = alpNumKey.textPressedColor; break;
        }


        main.nonStickyPressed(alpNumKey.keyCode)
    }

    function btnHovered(){
        if (!alpNumKey.hold){
            if (alpNumKey.entered){
                alpNumKey.color = alpNumKey.keyHoverColor
                lev0.color = alpNumKey.textColor
                lev1.color = alpNumKey.textColor
                lev2.color = alpNumKey.textColor
            }

            else {
                alpNumKey.color = alpNumKey.keyColor
                lev0.color = alpNumKey.textColor
                lev1.color = alpNumKey.textColor
                lev2.color = alpNumKey.textColor
            }
        }
    }

    function btnHold(){
        alpNumKey.hold = true
    }

    function btnReleased(){
        alpNumKey.hold = false
        btnHovered()


        main.nonStickyReleased(alpNumKey.keyCode)



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

}
