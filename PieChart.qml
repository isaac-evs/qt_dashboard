import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    color: "#ffffff"
    radius: 8
    border.color: "#e0e0e0"
    border.width: 1
    
    property var environmentData: [
        {name: "Sandbox", value: 10, color: "#9c27b0"},
        {name: "Development", value: 20, color: "#2196f3"},
        {name: "Test", value: 30, color: "#ff9800"},
        {name: "Production", value: 40, color: "#4caf50"}
    ]
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16
        
        Label {
            text: "Alerts by Environment"
            font.pixelSize: 16
            font.weight: Font.DemiBold
            color: "#2c3e50"
            Layout.fillWidth: true
        }
        
        // Pie chart visualization
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            Canvas {
                id: canvas
                anchors.centerIn: parent
                width: Math.min(parent.width, parent.height) - 40
                height: width
                
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    
                    var centerX = width / 2
                    var centerY = height / 2
                    var radius = Math.min(width, height) / 2 - 10
                    
                    var total = 0
                    for (var i = 0; i < root.environmentData.length; i++) {
                        total += root.environmentData[i].value
                    }
                    
                    var startAngle = -Math.PI / 2
                    
                    for (var i = 0; i < root.environmentData.length; i++) {
                        var data = root.environmentData[i]
                        var sliceAngle = (data.value / total) * 2 * Math.PI
                        
                        ctx.beginPath()
                        ctx.moveTo(centerX, centerY)
                        ctx.arc(centerX, centerY, radius, startAngle, startAngle + sliceAngle)
                        ctx.closePath()
                        ctx.fillStyle = data.color
                        ctx.fill()
                        
                        startAngle += sliceAngle
                    }
                }
                
                Component.onCompleted: requestPaint()
            }
        }
        
        // Legend
        GridLayout {
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 8
            columnSpacing: 16
            
            Repeater {
                model: root.environmentData
                
                RowLayout {
                    spacing: 8
                    
                    Rectangle {
                        width: 16
                        height: 16
                        radius: 2
                        color: modelData.color
                    }
                    
                    Label {
                        text: modelData.name + " (" + modelData.value + "%)"
                        font.pixelSize: 12
                        color: "#2c3e50"
                    }
                }
            }
        }
    }
}
