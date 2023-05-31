import QtQuick 
import QtQuick.Window 
import QtQuick.Controls 

TextField{
        id: myTimeEdit
        width:100
        height:50
        text : "00:00:00"
        inputMask: "99:99:99"
        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegularExpressionValidator { regularExpression: /^([0-1]?[0-9]|2[0-3]):([0-5][0-9]):[0-5][0-9]$ / }
        //anchors.top: parent.top; anchors.topMargin: 2
        //anchors.left: parent.left; anchors.leftMargin: 2
        horizontalAlignment:Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height/2.5
        font.family: "Helvetica"
        color: "#F99450"
        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        
        background:Rectangle{
            color:"transparent"
            border.color: "#F99450"
            border.width:2
            radius:(width * 0.05)
            }
        }