import QtQuick 2.3

// EnterKeyHead

Item {

    id: key

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor

    property string keyText

    property double keyWidth: main.keyWidth
    property double keyHeight: main.keyHeight
    property int keyLevel: main.keyLevel
    property int fontPointSize: main.keyHeight / 4
    property int keyRadius: main.keyHeight / 10
    property int keyCode: 36

    property bool hold: false
    property bool updateTheme: main.updateTheme
    property bool entered: false



    width: keyWidth * 3 / 2
    height: keyHeight * 2 + main.spacing



    function btnClicked(){
    }

    function btnPressed(){
        head.color = key.keyPressedColor
        foot.color = key.keyPressedColor
        headText.color = key.textPressedColor
        main.nonStickyPressed(key.keyCode)

    }

    function btnHovered(){
        if (!key.hold){

            if (key.entered){
                head.color = key.keyHoverColor
                headText.color = key.textColor
                foot.color = key.keyHoverColor
            }

            else {
                head.color = key.keyColor
                headText.color = key.textColor
                foot.color = key.keyColor
            }

        }

    }


    function btnHold(){
        key.hold = true
    }

    function btnReleased(){
        key.hold = false
        btnHovered()
        main.nonStickyReleased(key.keyCode)



    }




    Rectangle{
        id: head
        color: ma.containsMouse ? key.keyHoverColor : key.keyColor
        radius: key.keyRadius
        height: key.keyHeight
        width: key.width + main.spacing
        z: 10
        Text {
            id: headText
            color: key.textColor
            font.pixelSize: key.fontPointSize
            anchors {
                centerIn: head
            }
            text: "\u23CE Enter"

        }

        MouseArea{
            id: ma
            anchors.fill: parent
            hoverEnabled: main.keyHover

            onEntered: {
                key.entered = true
                btnHovered()
            }

            onExited: {
                key.entered = false
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
                btnClicked()
            }
        }

    }
    Rectangle{
        id: foot
        color: ma1.containsMouse ? key.keyHoverColor : key.keyColor
        radius: key.keyRadius
        width: key.keyWidth * 5 / 4 + main.spacing
        height: key.height


        anchors {
            top: head.top
            right: head.right
        }



        MouseArea{
            id: ma1
            anchors.fill: parent
            hoverEnabled: main.keyHover

            onEntered: {
                key.entered = true
                btnHovered()
            }

            onExited: {
                key.entered = false
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
                btnClicked()
            }
        }

    }

    onUpdateThemeChanged:{
        btnHovered()
    }
}
