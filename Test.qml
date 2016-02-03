import QtQuick 2.3
import QtQuick.Controls 1.2
import eta.helper 1.0

ApplicationWindow {
    id: test
    visible: true
    width: 400
    height: 100
    title: qsTr("xkbcommon-qmake-test")
    flags: Qt.WindowStaysOnTopHint | Qt.WindowDoesNotAcceptFocus

    property int layoutIndex : 0 // TRQ
    property string currentLayoutName
    property int keyLevel : 0
    property bool levelChanged : false


    Helper {
        id:helper
        onLayoutChanged: {
            console.log("signal from cpp");
            test.currentLayoutName = helper.getCurrentLayout()
            for(var i = 0; i< helper.getNumberOfLayouts();i++)
            {
                if ( test.currentLayoutName == comboModel.get(i).text) {
                    languages.currentIndex = i;
                    languages.update()
                }
                console.log(helper.getCurrentLayout());
            }
        }
    }
    function fakeKey(code){
        if (levelChanged) {
            switch(test.keyLevel){
            case 1:
                helper.fakeKeyPress(shift.keycode);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(shift.keycode);
                break
            case 2:
                helper.fakeKeyPress(altgr.keycode);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(altgr.keycode);
                break
            case 3:
                helper.fakeKeyPress(altgr.keycode);
                helper.fakeKeyPress(shift.keycode);
                helper.fakeKeyPress(code);
                helper.fakeKeyRelease(code);
                helper.fakeKeyRelease(shift.keycode);
                helper.fakeKeyRelease(altgr.keycode);
                break
            }
        } else {

            helper.fakeKeyPress(code);
            helper.fakeKeyRelease(code);

        }
    }

    Column {
        Row {
            id:row1
            Button {
                id : shift
                checkable: true
                property int keycode : 50
                text:"Shift"
                onCheckedChanged: {

                    if(shift.checked) {
                        test.keyLevel +=1;
                        test.levelChanged = true;
                    } else {

                        test.keyLevel -=1;
                        test.levelChanged = test.keyLevel!=0 ? true :false;
                    }
                }

            }
            Button {
                id:numericKey
                property int keycode : 13
                property int level : test.keyLevel
                text :helper.getSymbol(numericKey.keycode,test.layoutIndex,numericKey.level)
                onClicked: {
                    fakeKey(numericKey.keycode)
                }
            }

            Button {
                id:alphaKey
                property int keycode : 35
                property int level : test.keyLevel
                text : helper.getSymbol(alphaKey.keycode,test.layoutIndex,alphaKey.level)
                onClicked: {
                    fakeKey(alphaKey.keycode)
                }
            }
        }
        Row {
            id:row2
            Button {
                id :caps
                checkable: true
                property int keycode : 66
                text : "Caps_Lock"

                onClicked: {
                    helper.fakeKeyPress(caps.keycode);
                    helper.fakeKeyRelease(caps.keycode);

                }

            }
            Button {
                id : altgr
                checkable: true
                property int keycode : 108
                text:"Alt_Gr"

                onCheckedChanged: {

                    if(altgr.checked) {
                        test.keyLevel +=2;
                        test.levelChanged = true;
                    } else {
                        test.keyLevel -=2;
                        test.levelChanged = test.keyLevel!=0 ? true :false;
                    }
                }
            }
        }
        Row {
            id:row3
            Button {
                id :space
                width: row2.width
                property int keycode : 65
                property int level : test.keyLevel
                text :helper.getSymbol(space.keycode,test.layoutIndex,space.level)
                onClicked: {
                    fakeKey(space.keycode)
                }
            }
            ListModel {
                id:comboModel

            }

            ComboBox{
                id:languages
                editable: false
                model: comboModel
                onCurrentIndexChanged: {
                    test.layoutIndex = currentIndex;
                    console.log (comboModel.get(currentIndex).text);
                    helper.setLayout(comboModel.get(currentIndex).text);
                    test.currentLayoutName = comboModel.get(currentIndex).text;
                    console.log(test.layoutIndex + " --> selected layoutIndex");
                }

            }

        }
    }
    Component.onCompleted: {
        console.log("Number of layouts = "+helper.getNumberOfLayouts());
        //var model;
        for(var i = 0; i< helper.getNumberOfLayouts();i++)
        {
            comboModel.append({text:helper.getLayoutName(i)});

            console.log(helper.getLayoutName(i));
        }
    }

}
