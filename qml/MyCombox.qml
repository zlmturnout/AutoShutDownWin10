import QtQuick
import QtQuick.Controls

ComboBox {
    id: combox
    editable: false
    width:120;height:60
    font.pixelSize:16
    model: ListModel {
        id: model
        ListElement { text: "Banana"}
        ListElement { text: "Apple" }
        ListElement { text: "Coconut" }
    }
    onAccepted: {
        if (find(editText) === -1)
            model.append({text: editText})
    }
    onActivated:{
        combox.background.color="cyan"
    }
    indicator: Canvas {
        id: canvas
        x: combox.width - width - combox.rightPadding
        y: combox.topPadding + (combox.availableHeight - height) /2
        width: combox.width/4
        height: combox.height/3
        contextType: "2d"
        Connections {
            target: combox
                function onPressedChanged() { canvas.requestPaint(); }
            }
            onPaint: {
                context.reset();
                    context.moveTo(0, 0);
                    context.lineTo(width, 0);
                    context.lineTo(width / 2, height);
                    context.closePath();
                    context.fillStyle = combox.pressed ? "#17a81a" : "#3b7a57";
                    context.fill();
            }
        }       
        background: Rectangle{
            implicitWidth:80
            implicitHeight: 40
            border.color: combox.pressed ? "#17a81a" : "#bcd1c4"
            border.width: combox.visualFocus ? 2 : 1
            radius: 5
            color:"#635960"
            opacity: 0.3
        }
        popup: Popup {
        y: combox.height
        width: combox.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: combox.popup.visible ? combox.delegateModel : null
            currentIndex: combox.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "#21be2b"
            radius: 2
        }
    }
    
    
}