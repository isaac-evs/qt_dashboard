import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: card
    
    property string title: ""
    property string value: ""
    property bool isCritical: false
    
    color: "#ffffff"
    radius: 8
    border.color: "#e0e0e0"
    border.width: 1
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 8
        
        Label {
            text: card.title
            font.pixelSize: 13
            color: "#757575"
            Layout.fillWidth: true
        }
        
        Label {
            text: card.value
            font.pixelSize: 32
            font.weight: Font.Bold
            color: card.isCritical ? "#e53935" : "#2c3e50"
            Layout.fillWidth: true
        }
    }
}
