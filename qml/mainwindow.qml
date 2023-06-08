import QtQuick
import QtCore
import QtQuick.Controls
import QtQml
import QtQuick.Dialogs as StandardDialogs
import ShutDownWin10 1.0

ApplicationWindow {
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

        menuBar: MenuBar {
            //...
            delegate: MenuBarItem {
                id: menuBarItem
                font.pixelSize:18

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
                    implicitWidth: 30
                    implicitHeight: 30
                    opacity: enabled ? 1 : 0.3
                    color: menuBarItem.highlighted ? "#21be2b" : "transparent"
                }
            }
            Menu {
                title: qsTr("File")
                MenuItem {
                    text: qsTr("&Open image")
                    icon.name: "document-open"
                    onTriggered: fileOpenDialog.open()
                }
                MenuItem {
                    text: qsTr("&Gif image")
                    icon.name: "document-save"
                    onTriggered: openGifDialog.open()
                }
            }
            Menu {

                title: qsTr("Help")
                MenuItem {
                    text: qsTr("&About...")
                    onTriggered: aboutDialog.open()
                }
            }

        }

        Image {
            id: image
            asynchronous: true
            anchors.fill: parent
            //fillMode: Image.PreserveAspectFit
            fillMode: Image.Stretch
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "../img/lion.jpg"
            opacity: 0.4
        }

        StandardDialogs.FileDialog {
            id: openGifDialog
            title: "choose one Gif Image"
            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            nameFilters: ["Gif animation files (*.Gif)"]
            onAccepted: {
                //rect_gif.gifsource=openGifDialog.selectedFile
                animation.source=openGifDialog.selectedFile
            }
        }

        StandardDialogs.FileDialog {
            id: fileOpenDialog
            title: "choose one Image"
            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            nameFilters: ["Image files (*.jpg *.png *.jpeg *.webp)"]
            onAccepted: {
                image.source=fileOpenDialog.selectedFile
            }
        }

        Dialog {
            id: aboutDialog
            title: qsTr("About")
            modal: true
            anchors.centerIn: parent
            Label {
                anchors.centerIn: parent
                text: "Image background with opacity"
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Win10ShutDown {
            id: shutdownwin10
        }
        
        Row{
        padding:5
        spacing:1
        
        Rectangle{
            id: rect0
            width:400;height: 400
            //opacity: 0.9
            color: "transparent"


            Column {
            spacing: 10
            padding: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: rect1
                width: 400; height: 40
                //x:80;y: 100
                color:"transparent"
                Text {
                    text: "Win10 Auto ShutDown"
                    color: "#21be2b"
                    opacity: 1
                    font.family: "Ubuntu"
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
            }
            Rectangle { id:linespace;width:400;height: 40; color: "#1DB784"
                Text {
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
                Flow {
                    anchors.fill: parent
                    anchors.margins: 4
                    spacing: 10
                    Rectangle {
                        width:150;height: 50; color: "#1DB784"
                        Text {
                            text: "Time After"
                            color: "#F99450"
                            font.pixelSize: 20
                            anchors.centerIn: parent
                        }

                    }
                    TimeEdit {
                        id: timeEdit
                        text : "01:00:00"

                    }
                    MyButton {
                        id: set_btn
                        text: "Set"
                        tip_text: qsTr("Set Time and Start countdown")
                        onClicked: {//setClicked(timeEdit.text);
                        counts=shutdownwin10.getTimeSet(timeEdit.text)+10
                        countTimer.start()}
                    }
                }
            }
            Rectangle {
                id:countdown;width:400;height: 40; color: "#1DB784"
                Text {
                    text: "Count Down"
                    color: "white"
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
            }
            Row {
                spacing:10
                Rectangle {
                    id: seconds_left
                    width:260;height: 50; color: "#F99450"
                    Text {
                        text: counts.toString()
                        color: "white"
                        font.pixelSize: 40
                        anchors.centerIn: parent
                    }
                }
                MyButton {
                    id: stopBtn
                    text: "STOP"
                    height: 50
                    tip_text: qsTr("Stop countdown")
                    onClicked: {countTimer.stop()}
                }
            }
        }
    }
    Rectangle {
            id: rect_gif
            width: animation.width;height: animation.height+8;
            property alias gifsource: animation.source

            AnimatedImage {
                id: animation
                source:"../img/JessicaAlba.gif"
            }

            Component.onCompleted: {
                 frames=animation.frameCount
            }

            Rectangle {
                property int frames
                width:4;height:8
                x: (animation.width-width)*animation.currentFrame/frames
                y:animation.height
                color:"blue"
            }
        }
    MyCombox{
        id:mycombox
    }
    MyButton{
        id: com_btn
        onClicked:{
            mycombox.model.append( {text:"Orange"})
        }
    }

}
        
        


        Item {
            property var locale: Qt.locale()
            //property date currentTime: new Date()
            Timer {
                id: showTimer
                interval: 500; running: true; repeat: true
                onTriggered: currentTime.text = new Date().toLocaleString(locale, Locale.LongFormat)
            }
            Timer {
                id: countTimer
                interval: 1000; running: false; repeat: true
                onTriggered: {
                    counts=counts-1
                    if (counts==0)
                        shutdownwin10.shutdown()

                }
            }
        }
    }
