import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    color: "#ffffff"
    radius: 8
    border.color: "#e0e0e0"
    border.width: 1
    
    ListModel {
        id: serversModel
        ListElement { name: "ServerA"; alerts: 8 }
        ListElement { name: "ServerB"; alerts: 5 }
        ListElement { name: "ServerC"; alerts: 4 }
        ListElement { name: "ServerD"; alerts: 3 }
        ListElement { name: "ServerE"; alerts: 2 }
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16
        
        Label {
            text: "Top 5 Servers by Alerts"
            font.pixelSize: 16
            font.weight: Font.DemiBold
            color: "#2c3e50"
            Layout.fillWidth: true
        }
        
        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: serversModel
            spacing: 12
            clip: true
            
            delegate: RowLayout {
                width: ListView.view.width
                spacing: 12
                
                Label {
                    text: (index + 1) + "."
                    font.pixelSize: 14
                    color: "#757575"
                    Layout.preferredWidth: 20
                }
                
                Label {
                    text: model.name
                    font.pixelSize: 14
                    color: "#2c3e50"
                    Layout.fillWidth: true
                }
                
                Label {
                    text: model.alerts + " alerts"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    color: "#f57c00"
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }
}
