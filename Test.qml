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

    property int layout : 0 // TRQ
    property int keyLevel : 0
    property bool levelChanged : false


    Helper {
        id:helperId
    }
    function fakeKey(code){
        if (levelChanged) {
            switch(test.keyLevel){
            case 1:
                helperId.fakeKeyPress(shift.keycode);
                helperId.fakeKeyPress(code);
                helperId.fakeKeyRelease(code);
                helperId.fakeKeyRelease(shift.keycode);
                break
            case 2:
                helperId.fakeKeyPress(altgr.keycode);
                helperId.fakeKeyPress(code);
                helperId.fakeKeyRelease(code);
                helperId.fakeKeyRelease(altgr.keycode);
                break
            case 3:
                helperId.fakeKeyPress(altgr.keycode);
                helperId.fakeKeyPress(shift.keycode);
                helperId.fakeKeyPress(code);
                helperId.fakeKeyRelease(code);
                helperId.fakeKeyRelease(shift.keycode);
                helperId.fakeKeyRelease(altgr.keycode);
                break
            }
        } else {

            helperId.fakeKeyPress(code);
            helperId.fakeKeyRelease(code);

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
                text :helperId.getSymbol(numericKey.keycode,test.layout,numericKey.level)
                onClicked: {
                    fakeKey(numericKey.keycode)
                }
            }

            Button {
                id:alphaKey
                property int keycode : 35
                property int level : test.keyLevel
                text : test.levelChanged ? helperId.getSymbol(alphaKey.keycode,test.layout,alphaKey.level) : helperId.getSymbol(alphaKey.keycode,test.layout,1)
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
                    helperId.fakeKeyPress(caps.keycode);
                    helperId.fakeKeyRelease(caps.keycode);

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
                text :helperId.getSymbol(space.keycode,test.layout,space.level)
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
                    test.layout = currentIndex;
                    console.log (comboModel.get(currentIndex).text);
                    helperId.setLayout(comboModel.get(currentIndex).text);
                    console.log(test.layout + " --> selected layout");
                }

            }

        }
    }
    Component.onCompleted: {
        console.log("Number of layouts = "+helperId.getNumberOfLayouts());
        //var model;
        for(var i = 0; i< helperId.getNumberOfLayouts();i++)
        {
            comboModel.append({text:helperId.getLayoutName(i)});

            console.log(helperId.getLayoutName(i));
        }
        //languages.model = model;
    }

}
