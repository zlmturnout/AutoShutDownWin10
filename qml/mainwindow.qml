import QtQuick
import QtQuick.Controls
import QtQml
import ShutDownWin10 1.0

ApplicationWindow{
    id: root
    opacity: 0.9
    title: qsTr("AutoShutDown_Win10")
    //color: "#21be2b"
    visible: true
    width: 500
    height: 500
    property int counts: 1500
    property int new_counts
    signal setClicked(var timestring)
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
        Win10ShutDown{
            id: shutdownwin10

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
            id: timeset
            width: 400; height: 60; color: "transparent"
            Flow{
                anchors.fill: parent
                anchors.margins: 4
                spacing: 10
                Rectangle{
                    width:150;height: 50; color: "#1DB784"
                    Text{
                        text: "Time After"
                        color: "#F99450"
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }
                
                }
                TimeEdit{
                    id: timeEdit
                    text : "01:00:00"

                }
                MyButton{
                    id: set_btn
                    text: "Set"
                    tip_text: qsTr("Set Time and Start countdown")
                    onClicked: {//setClicked(timeEdit.text);
                    counts=shutdownwin10.getTimeSet(timeEdit.text)+10
                    countTimer.start()}
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
                id: seconds_left
                width:260;height: 50; color: "#F99450"
                Text{
                    text: counts.toString()
                    color: "white"
                    font.pixelSize: 40
                    anchors.centerIn: parent
                }
            }
            MyButton{
                id: stopBtn
                text: "STOP"
                height: 50
                tip_text: qsTr("Stop countdown")
                onClicked: {countTimer.stop()}
            }
        }
    }

    Item {
        property var locale: Qt.locale()
        //property date currentTime: new Date()
        Timer {
            id: showTimer
            interval: 500; running: true; repeat: true
            onTriggered: currentTime.text = new Date().toLocaleString(locale,Locale.LongFormat)
        }
        Timer{
            id: countTimer
            interval: 1000; running: false; repeat: true
            onTriggered: {
            counts=counts-1
            if(counts==0)
                shutdownwin10.shutdown()

            }
        }
    }
}
