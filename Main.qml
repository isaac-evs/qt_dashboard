import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1400
    height: 900
    title: "System Monitoring Dashboard"
    
    color: "#f5f5f5"
    
    // Data model for navigation items
    ListModel {
        id: navigationModel
        ListElement { name: "EC2 Disk Storage"; viewId: "ec2_disk" }
        ListElement { name: "Network Latency"; viewId: "network"; enabled: false }
        ListElement { name: "CPU Usage"; viewId: "cpu"; enabled: false }
    }
    
    RowLayout {
        anchors.fill: parent
        spacing: 0
        
        // Left Navigation Sidebar
        Rectangle {
            Layout.preferredWidth: 220
            Layout.fillHeight: true
            color: "#ffffff"
            border.color: "#e0e0e0"
            border.width: 1
            
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                
                // Header
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 80
                    color: "transparent"
                    
                    Label {
                        anchors.centerIn: parent
                        text: "Dashboard"
                        font.pixelSize: 20
                        font.weight: Font.DemiBold
                        color: "#2c3e50"
                    }
                }
                
                // Navigation List
                ListView {
                    id: navigationList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: navigationModel
                    currentIndex: 0
                    clip: true
                    
                    delegate: ItemDelegate {
                        width: navigationList.width
                        height: 56
                        enabled: model.enabled !== false
                        
                        background: Rectangle {
                            color: {
                                if (!parent.enabled) return "transparent"
                                if (navigationList.currentIndex === index) return "#e3f2fd"
                                if (parent.hovered) return "#f5f5f5"
                                return "transparent"
                            }
                            
                            Rectangle {
                                anchors.left: parent.left
                                width: 4
                                height: parent.height
                                color: "#2196f3"
                                visible: navigationList.currentIndex === index
                            }
                        }
                        
                        contentItem: Label {
                            text: model.name
                            font.pixelSize: 14
                            color: parent.enabled ? 
                                   (navigationList.currentIndex === index ? "#1976d2" : "#2c3e50") :
                                   "#bdbdbd"
                            leftPadding: 24
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            if (parent.enabled) {
                                navigationList.currentIndex = index
                                contentLoader.sourceComponent = getViewComponent(model.viewId)
                            }
                        }
                    }
                }
                
                // Footer
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    color: "transparent"
                    
                    Label {
                        anchors.centerIn: parent
                        text: "v1.0.0"
                        font.pixelSize: 11
                        color: "#9e9e9e"
                    }
                }
            }
        }
        
        // Main Content Area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#f5f5f5"
            
            Loader {
                id: contentLoader
                anchors.fill: parent
                anchors.margins: 0
                sourceComponent: ec2DiskStorageComponent
            }
        }
    }
    
    // Component definitions
    Component {
        id: ec2DiskStorageComponent
        EC2DiskStorage {}
    }
    
    // Helper function to get view component
    function getViewComponent(viewId) {
        switch(viewId) {
            case "ec2_disk":
                return ec2DiskStorageComponent
            default:
                return null
        }
    }
}
