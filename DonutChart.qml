import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    color: "#ffffff"
    radius: 8
    border.color: "#e0e0e0"
    border.width: 1
    
    property var regionData: [
        {name: "Beijing", value: 25, color: "#e91e63"},
        {name: "Frankfurt", value: 30, color: "#3f51b5"},
        {name: "Singapore", value: 20, color: "#00bcd4"},
        {name: "Ohio", value: 25, color: "#8bc34a"}
    ]
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 16
        
        Label {
            text: "Traffic by Region"
            font.pixelSize: 16
            font.weight: Font.DemiBold
            color: "#2c3e50"
            Layout.fillWidth: true
        }
        
        // Donut chart visualization
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
                    var outerRadius = Math.min(width, height) / 2 - 10
                    var innerRadius = outerRadius * 0.6
                    
                    var total = 0
                    for (var i = 0; i < root.regionData.length; i++) {
                        total += root.regionData[i].value
                    }
                    
                    var startAngle = -Math.PI / 2
                    
                    for (var i = 0; i < root.regionData.length; i++) {
                        var data = root.regionData[i]
                        var sliceAngle = (data.value / total) * 2 * Math.PI
                        var endAngle = startAngle + sliceAngle
                        
                        // Draw outer arc
                        ctx.beginPath()
                        ctx.arc(centerX, centerY, outerRadius, startAngle, endAngle)
                        ctx.arc(centerX, centerY, innerRadius, endAngle, startAngle, true)
                        ctx.closePath()
                        ctx.fillStyle = data.color
                        ctx.fill()
                        
                        startAngle = endAngle
                    }
                    
                    // Draw center circle
                    ctx.beginPath()
                    ctx.arc(centerX, centerY, innerRadius, 0, 2 * Math.PI)
                    ctx.fillStyle = "#ffffff"
                    ctx.fill()
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
                model: root.regionData
                
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
