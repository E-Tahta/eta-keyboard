import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.0
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import eta.helper 1.0

ApplicationWindow {
    id: settings

    flags: Qt.WindowStaysOnBottomHint | Qt.FramelessWindowHint | Qt.X11BypassWindowManagerHint

    property bool settingsVisible: main.settingsVisible
    property int settingsWidth: main.width / 6
    property int settingsHeight: main.height / 6
    property string keyColor


    width: settings.settingsWidth
    height:settings.settingsHeight
    visible: true
    color: main.color


    x: main.x - settings.width - main.spacing
    y: main.y + main.height - settings.height


    Helper{
        id: helperId
    }

    ListModel {
        id:languageModel
    }

    ListModel {
        id: colorModel
        ListElement {text:"grey"; kColor:"#585858"; tColor:"#dddddd"; atColor:"white";hColor:"#848484"; bColor: "#010101"}
        ListElement {text:"green"; kColor:"dark green"; tColor:"white"; atColor:"white";hColor:"green"; bColor: "#010101"}
        ListElement {text:"blue"; kColor:"#1b50b8"; tColor:"#fbfcfe"; atColor:"#fbfcfe";hColor:"#3980f4";bColor: "#010101"}
    }

    Grid{

        columns: 1
        spacing: 1

        ComboBox{
            id:languages
            editable: false
            model: languageModel
            // width: settings.width / 2


            onCurrentIndexChanged: {
                if(count>1){
                    main.languageLayoutIndex = currentIndex;
                    helperId.setLayout(languageModel.get(currentIndex).text);
                }

            }
        }


        ComboBox{
            id:colors
            editable: false
            model: colorModel
            // width: settings.width / 2

            onCurrentIndexChanged: {
                main.keyColor = colorModel.get(currentIndex).kColor;
                main.textColor = colorModel.get(currentIndex).tColor;
                main.activeTextColor = colorModel.get(currentIndex).atColor;
                main.keyHoverColor = colorModel.get(currentIndex).hColor;
                main.color = colorModel.get(currentIndex).bColor;
                main.updateTheme = !main.updateTheme

            }
        }
    }



    onSettingsVisibleChanged: {

    }


    Component.onCompleted: {

        for(var i = 0; i< helper.getNumberOfLayouts();i++)
        {
            languageModel.append({text:helper.getLayoutName(i)});
        }


    }
}
