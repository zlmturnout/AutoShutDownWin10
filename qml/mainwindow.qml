import QtQuick
import QtQuick.Controls

ApplicationWindow{
    id: root
    opacity: 0.9
    title: qsTr("AutoShutDown_Win10")
    //color: "#21be2b"
    visible: true
    width: 500
    height: 500
    
    //anchors.centerIn: parent
    
    //horizontalAlignment: root.AlignLeft
    //verticalAlignment: root.AlignVCenter

    menuBar: MenuBar{
        //...
        delegate: MenuBarItem {
            id: menuBarItem

            contentItem: Text {
                text: menuBarItem.text
                font: menuBarItem.font
                opacity: enabled ? 1.0 : 0.3
                color: menuBarItem.highlighted ? "#ffffff" : "#21be2b"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                opacity: enabled ? 1 : 0.3
                color: menuBarItem.highlighted ? "#21be2b" : "transparent"
            }
        }
        Menu{
            title: qsTr("&File")
            MenuItem{
                text: qsTr("&Open image")
                icon.name: "document-open"
                onTriggered: openImage()
            }
            MenuItem {
                text: qsTr("&Save")
                icon.name: "document-save"
                onTriggered: saveImage()
            }
        }
        Menu{
            
            title: qsTr("Help")
            MenuItem{
                text: qsTr("&About...")
                onTriggered: OpenAboutDialog()
            }
        }

    }
    Column{
        spacing: 10
        padding: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        
        Rectangle{
            id: rect1
            width: 400; height: 40
            //x:80;y: 100
            color:"transparent"
            Text{
            text: "Win10 Auto ShutDown"
            color: "#21be2b"
            opacity: 1
            font.family: "Ubuntu"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
        }
        Rectangle{ id:linespace;width:400;height: 40; color: "#1DB784"
            Text{
                id: currentTime
                text: ""
                color: "white"
                font.pixelSize: 20
                anchors.centerIn: parent
                }
            }
        Rectangle{
            id:timeset
            width: 400; height: 60; color: "transparent"
            Flow{
                anchors.fill: parent
                anchors.margins: 4
                spacing: 10
                Rectangle{
                    width:100;height: 50; color: "#1DB784"
                    Text{
                        text: "TimeAfter"
                        color: "#F99450"
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }
                
                }
                TimeEdit{

                }
                MyButton{
                    id: set_btn
                    text: "Set"
                    tip_text: qsTr("Set Time and Start countdown")
                    onClicked: startCount()
                }
            }
        }
        Rectangle{ 
            id:countdown;width:400;height: 40; color: "#1DB784"
            Text{
                text: "Count Down"
                color: "white"
                font.pixelSize: 20
                anchors.centerIn: parent
                }
            }
        Row{
            spacing:10
            Rectangle{
                width:210;height: 50; color: "#F99450"
                Text{
                    text: ""
                    color: "#1DB784"
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
            }
            MyButton{
                id: stopBtn
                text: "STOP"
                tip_text: qsTr("Stop countdown")
                onClicked: stopCount()
            }
        }
    }

    Item {
        property var locale: Qt.locale()
        //property date currentTime: new Date()
        Timer {
            
            interval: 500; running: true; repeat: true
            onTriggered: currentTime.text = new Date().toLocaleString(locale,Locale.LongFormat)
        }
}


}