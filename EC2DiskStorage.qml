import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: root
    
    clip: true
    contentWidth: availableWidth
    
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    
    Flickable {
        contentHeight: mainLayout.height + 40
        boundsBehavior: Flickable.StopAtBounds
        
        ColumnLayout {
            id: mainLayout
            width: root.availableWidth
            spacing: 24
            
            // Page header
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.topMargin: 20
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 4
                    
                    Label {
                        text: "EC2 Disk Storage"
                        font.pixelSize: 28
                        font.weight: Font.Bold
                        color: "#2c3e50"
                    }
                    
                    Label {
                        text: "Real-time monitoring of disk storage across EC2 instances"
                        font.pixelSize: 13
                        color: "#757575"
                    }
                }
            }
            
            // Overview Cards Row
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 120
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 16
                
                OverviewCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    title: "Total Alerts"
                    value: "12"
                }
                
                OverviewCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    title: "Total Instances"
                    value: "5"
                }
                
                OverviewCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    title: "Total Disks"
                    value: "42"
                }
                
                OverviewCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    title: "Critical Alerts"
                    value: "3"
                    isCritical: true
                }
            }
            
            // Middle Section: Top Servers & Scatter Plot
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 350
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 16
                
                TopServersList {
                    Layout.preferredWidth: 320
                    Layout.fillHeight: true
                }
                
                ScatterPlot {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
            
            // Charts Row: Pie Chart & Donut Chart
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 320
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                spacing: 16
                
                PieChart {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
                
                DonutChart {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
            
            // Timeline Chart
            TimelineChart {
                Layout.fillWidth: true
                Layout.preferredHeight: 280
                Layout.leftMargin: 32
                Layout.rightMargin: 32
                Layout.bottomMargin: 20
            }
        }
    }
}
