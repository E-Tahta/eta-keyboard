import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import eta.helper 1.0

Item{

    id: tabletLay

    Helper {
        id:helperId
    }




    Column{
        id: col1
        spacing: main.spacing


        Rectangle {
            id: dock
            height: main.dockSize
            width: main.width
            color: main.color


            ListModel {
                id:comboModel

            }


            ComboBox{
                id:languages
                editable: false
                model: comboModel
                onCurrentIndexChanged: {
                    main.languageLayoutIndex = currentIndex;
                    helperId.setLayout(comboModel.get(currentIndex).text);

                }

            }

            Image {
                id: closeBtnImage
                source: "Images/window-close.png"

                anchors.right: dock.right
                anchors.top: dock.top
                anchors.bottom: dock.bottom
                height:main.dockSize
                width: closeBtnImage.height
                MouseArea{
                    anchors.fill: closeBtnImage
                    onClicked: Qt.quit()
                }
            }




            MouseArea{
                anchors{
                    top: dock.top
                    left: languages.right
                    bottom: dock.bottom
                    right:closeBtnImage.left
                }
                property variant cpos: "1,1"
                onPressed: {
                    cpos = Qt.point(mouse.x,mouse.y);
                }
                onPositionChanged: {
                    var delta = Qt.point(mouse.x - cpos.x, mouse.y - cpos.y);
                    main.x += delta.x;
                    main.y += delta.y;
                }
            }
        }
    }






    Component.onCompleted: {

        for(var i = 0; i< helperId.getNumberOfLayouts();i++)
        {
            comboModel.append({text:helperId.getLayoutName(i)});


        }

    }
}
