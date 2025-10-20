import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    color: "#ffffff"
    radius: 8
    border.color: "#e0e0e0"
    border.width: 1
    
    // Sample data: critical alerts per hour for last 24 hours
    property var alertsData: [
        2, 3, 1, 2, 4, 3, 5, 7, 8, 10, 12, 9,
        11, 13, 15, 14, 12, 10, 9, 8, 6, 5, 4, 3
    ]
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16
        
        Label {
            text: "Critical Alerts Timeline"
            font.pixelSize: 16
            font.weight: Font.DemiBold
            color: "#2c3e50"
            Layout.fillWidth: true
        }
        
        Label {
            text: "Number of Critical Alerts per Hour (Last 24h, CT)"
            font.pixelSize: 12
            color: "#757575"
            Layout.fillWidth: true
        }
        
        // Chart area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#fafafa"
            radius: 4
            border.color: "#e0e0e0"
            border.width: 1
            
            Item {
                anchors.fill: parent
                anchors.margins: 40
                
                // Y-axis labels
                Column {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: -35
                    spacing: (parent.height - 10) / 5
                    
                    Repeater {
                        model: 6
                        Label {
                            text: (15 - index * 3)
                            font.pixelSize: 10
                            color: "#757575"
                            horizontalAlignment: Text.AlignRight
                            width: 30
                        }
                    }
                }
                
                // Y-axis title
                Label {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: -55
                    text: "Critical Alerts"
                    font.pixelSize: 11
                    color: "#616161"
                    rotation: -90
                    transformOrigin: Item.Center
                }
                
                // Horizontal grid lines
                Repeater {
                    model: 6
                    Rectangle {
                        x: 0
                        y: index * (parent.height / 5)
                        width: parent.width
                        height: 1
                        color: "#e0e0e0"
                    }
                }
                
                // Bar chart
                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: parent.height
                    spacing: 2
                    
                    Repeater {
                        model: root.alertsData
                        
                        Rectangle {
                            width: (parent.width - (root.alertsData.length - 1) * 2) / root.alertsData.length
                            height: (modelData / 15) * parent.height
                            anchors.bottom: parent.bottom
                            color: {
                                if (modelData >= 10) return "#e53935"
                                if (modelData >= 5) return "#f57c00"
                                return "#fbc02d"
                            }
                            radius: 2
                            
                            ToolTip {
                                visible: mouseArea.containsMouse
                                text: "Hour " + index + ": " + modelData + " alerts"
                                delay: 200
                            }
                            
                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                            }
                        }
                    }
                }
                
                // X-axis labels
                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.bottom
                    anchors.topMargin: 8
                    spacing: (parent.width - 100) / 5
                    
                    Repeater {
                        model: ["0h", "4h", "8h", "12h", "16h", "20h"]
                        Label {
                            text: modelData
                            font.pixelSize: 10
                            color: "#757575"
                        }
                    }
                }
                
                // X-axis title
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: 25
                    text: "Time (Hours) - Last 24h (CT)"
                    font.pixelSize: 11
                    color: "#616161"
                }
            }
        }
    }
}
