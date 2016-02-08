import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.0
import QtQuick.Window 2.0
import eta.helper 1.0

ApplicationWindow {
    id: settings


    property bool settingsVisible: main.settingsVisible
    property int settingsWidth: main.width / 8
    property int settingsHeight: main.height / 6

    flags: Qt.X11BypassWindowManagerHint

    width: settings.settingsWidth
    height:settings.settingsHeight
    visible: true
    opacity: 0
    color: main.color


    x: main.x - settings.width
    y: main.y + main.height - settings.height








    Helper{
        id: helperId
    }

    ListModel {
        id:comboModel


    }

    ComboBox{
        id:languages
        editable: false
        model: comboModel
        height: settings.height
        width: settings.width





        onCurrentIndexChanged: {
            main.languageLayoutIndex = currentIndex;
            helperId.setLayout(comboModel.get(currentIndex).text);

        }
    }




    ParallelAnimation {
        id: showSettings
        NumberAnimation {
            target:settings
            property: "width"
            from:0
            to : settings.settingsWidth
            duration: 500
            easing.type: Easing.OutBounce

        }

        NumberAnimation {
            target: settings
            property: "opacity"
            from: 0
            to : 1
            duration: 200


        }

    }







    ParallelAnimation {
        id: hideSettings

        NumberAnimation {
            target:settings
            property: "width"
            from:settings.settingsWidth
            to : 0
            duration: 500
            easing.type: Easing.OutBounce

        }
        NumberAnimation {
            target: settings
            property: "opacity"
            from: 1
            to : 0
            duration: 200


        }
    }


    onSettingsVisibleChanged: {
        if (!settings.settingsVisible)
            showSettings.start()
        else hideSettings.start()
    }




    Component.onCompleted: {




        //console.log("Number of layouts = "+helper.getNumberOfLayouts());
        for(var i = 0; i< helper.getNumberOfLayouts();i++)
        {
            comboModel.append({text:helper.getLayoutName(i)});
        }
    }
}
