import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    color: "#ffffff"
    radius: 8
    border.color: "#e0e0e0"
    border.width: 1
    
    property var instances: ["Instance-1", "Instance-2", "Instance-3", "Instance-4", "Instance-5"]
    property var disks: {
        "Instance-1": ["Disk C:", "Disk E:", "Disk F:"],
        "Instance-2": ["Disk C:", "Disk D:"],
        "Instance-3": ["Disk C:", "Disk E:", "Disk G:"],
        "Instance-4": ["Disk C:"],
        "Instance-5": ["Disk C:", "Disk D:", "Disk E:", "Disk F:"]
    }
    
    // Sample data points for the scatter plot (24 hours, percentage)
    property var dataPoints: [
        {hour: 0, usage: 72}, {hour: 1, usage: 73}, {hour: 2, usage: 74},
        {hour: 3, usage: 75}, {hour: 4, usage: 76}, {hour: 5, usage: 78},
        {hour: 6, usage: 80}, {hour: 7, usage: 82}, {hour: 8, usage: 85},
        {hour: 9, usage: 87}, {hour: 10, usage: 88}, {hour: 11, usage: 89},
        {hour: 12, usage: 90}, {hour: 13, usage: 91}, {hour: 14, usage: 92},
        {hour: 15, usage: 93}, {hour: 16, usage: 94}, {hour: 17, usage: 95},
        {hour: 18, usage: 94}, {hour: 19, usage: 93}, {hour: 20, usage: 92},
        {hour: 21, usage: 91}, {hour: 22, usage: 89}, {hour: 23, usage: 88}
    ]
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16
        
        // Title and dropdowns
        RowLayout {
            Layout.fillWidth: true
            spacing: 12
            
            Label {
                text: "Disk Usage Over Time"
                font.pixelSize: 16
                font.weight: Font.DemiBold
                color: "#2c3e50"
                Layout.fillWidth: true
            }
            
            ComboBox {
                id: instanceCombo
                model: root.instances
                Layout.preferredWidth: 140
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : (parent.hovered ? "#f5f5f5" : "#ffffff")
                    border.color: "#bdbdbd"
                    border.width: 1
                    radius: 4
                }
                
                contentItem: Text {
                    text: instanceCombo.displayText
                    font.pixelSize: 12
                    color: "#2c3e50"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 8
                }
            }
            
            ComboBox {
                id: diskCombo
                model: root.disks[instanceCombo.currentText] || []
                Layout.preferredWidth: 120
                
                background: Rectangle {
                    color: parent.pressed ? "#e0e0e0" : (parent.hovered ? "#f5f5f5" : "#ffffff")
                    border.color: "#bdbdbd"
                    border.width: 1
                    radius: 4
                }
                
                contentItem: Text {
                    text: diskCombo.displayText
                    font.pixelSize: 12
                    color: "#2c3e50"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 8
                }
            }
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
                
                // Y-axis labels and grid
                Column {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: -35
                    spacing: (parent.height - 10) / 6
                    
                    Repeater {
                        model: 7
                        Label {
                            text: (100 - index * 5) + "%"
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
                    text: "Storage Filled %"
                    font.pixelSize: 11
                    color: "#616161"
                    rotation: -90
                    transformOrigin: Item.Center
                }
                
                // Horizontal grid lines
                Repeater {
                    model: 7
                    Rectangle {
                        x: 0
                        y: index * (parent.height / 6)
                        width: parent.width
                        height: 1
                        color: "#e0e0e0"
                    }
                }
                
                // Data points
                Repeater {
                    model: root.dataPoints
                    Rectangle {
                        x: (modelData.hour / 23) * (parent.width - 8)
                        y: ((100 - modelData.usage) / 30) * parent.height
                        width: 8
                        height: 8
                        radius: 4
                        color: {
                            if (modelData.usage >= 95) return "#e53935"
                            if (modelData.usage >= 90) return "#f57c00"
                            return "#2196f3"
                        }
                        
                        ToolTip {
                            visible: parent.hovered
                            text: "Hour " + modelData.hour + ": " + modelData.usage + "%"
                            delay: 200
                        }
                        
                        property bool hovered: false
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.hovered = true
                            onExited: parent.hovered = false
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
