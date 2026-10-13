import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import QtQuick
import qs.bar.modules
import qs.theme

Variants {
    id: root
    model: Quickshell.screens
    delegate: PanelWindow {
        id: mainBar
        required property var modelData
        screen: modelData

        // --- Geometry & Positioning ---
        anchors {
            top: true
            left: true
            right: true
        }

        color: "transparent"
        implicitHeight: Layout.bar.height

        // This margin is important so that the gap between the window and the bar isn't too big
        margins {
            bottom: Layout.bar.bottomMargin
        }

        exclusionMode: ExclusionMode.Auto

        // --- Core Modules ---
        Row {
            id: leftModules
            
            anchors {
                left: parent.left
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }

            spacing: 10

            Workspaces {
                id: workspaceModule
                targetMonitor: modelData.name
            }

            MusicPlaying {
                id: musicModule
            }
        }

        Row {
            id: centerModules
            
            anchors {
                centerIn: parent
            }

            spacing: 10
        }
        
        Row {
            id: rightModules
            
            anchors {
                right: parent.right
                rightMargin: 15
                verticalCenter: parent.verticalCenter
            }

            spacing: 10

            ScreenRecording {
                id: screenRecording
            }

            CurrentWeather {
                id: currentWeather
            }

            SystemStats {
                id: statusModule
            }

            Calendar {
                id: calendarModule
            }
        }
    }
}
