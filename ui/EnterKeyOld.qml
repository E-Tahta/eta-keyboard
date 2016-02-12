import QtQuick 2.3
Item {


    id: entKey

    property string keyColor: main.keyColor
    property string keyPressedColor: main.keyPressedColor
    property string keyHoverColor: main.keyHoverColor
    property string textColor: main.textColor
    property string textPressedColor: main.textPressedColor
    property string keySymbolLevel1
    property int keyWidth: main.keyWidth
    property int keyHeight: main.keyHeight
    property int fontPointSize: 10

    property int keyCode: 24

    property bool hold: false
    property bool entered: false

    width: keyWidth * 8 / 5
    height: keyHeight * 2 + main.columnSpacing


    function btnClicked(){
    }

    function btnPressed(){
        head.color = entKey.keyPressedColor
        foot.color = entKey.keyPressedColor
        symbol.color = entKey.keyPressedColor

        main.nonStickyPressed(entKey.keyCode)
    }

    function btnHovered(){
        if (!entKey.hold){

            if (entKey.entered){
                head.color = entKey.keyHoverColor
                symbol.color = entKey.textColor
                foot.color = entKey.keyHoverColor
            }

            else {
                head.color = entKey.keyColor
                symbol.color = entKey.textColor
                foot.color = entKey.keyColor
            }

        }

    }

    function btnHold(){
        entKey.hold = true
    }

    function btnReleased(){
        entKey.hold = false
        btnHovered()

        main.nonStickyReleased(entKey.keyCode)

    }

    Rectangle{
        id: head
        color: entKey.keyColor
        radius: entKey.keyHeight/10

        height: entKey.keyHeight
        width: entKey.width
        z: 1

        Text {
            id: symbol
            color: textColor
            font.pointSize: fontPointSize
            anchors {
                centerIn: head
            }
            text: "\u23CE Enter"
        }


        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                entKey.entered = true
                btnHovered()
            }

            onExited: {
                entKey.entered = false
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
        }
    }

    Rectangle{
        id: foot
        color: entKey.keyColor
        radius: entKey.keyHeight/10

        z: 0

        width: entKey.keyWidth * 13 / 10
        height: entKey.height

        anchors {
            top: head.top
            right: head.right
        }


        MouseArea{
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                entKey.entered = true
                btnHovered()
            }

            onExited: {
                entKey.entered = false
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
        }
    }


}
