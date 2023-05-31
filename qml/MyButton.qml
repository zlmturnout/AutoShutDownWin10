import QtQuick
import QtQuick.Controls

Button{
        id: mybutton
        text: qsTr("Button")
        property var tip_text: "tips"
        width: 100; height: 50        
        font.bold: true
        font.family: "Helvetica"
        font.pixelSize: 20
        contentItem: Text{
            id: btn_text
            text: parent.text
            font: parent.font
            opacity: enabled ? 1.0 : 0.3
            color:  parent.hovered ? "#F99450" : "white" 
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle{
                id: buttonbg
                implicitWidth:100
                implicitHeight: 50
                //color: parent.down ? "#00994C" : (parent.hovered ? "#F99450" : "#00994C")
                color: parent.hovered ? "#F99450" : "#00994C"
                opacity: enabled ? 1 : 0.3
                border.color: parent.down ? "white" : "#F99450"
                border.width: 1
                radius: 2
                }
        hoverEnabled: true
        ToolTip{
            delay: 1000
            timeout: 1000
            visible: parent.hovered
            text: tip_text
        }
    }