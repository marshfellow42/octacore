import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Networking
import qs.theme

// --- Internet Module ---
Row {
    id: internetModule
    spacing: 8

    readonly property var currentNetworkDevice: Networking.devices.values[0] ?? null
    readonly property bool hasNetwork: currentNetworkDevice !== null && (currentNetworkDevice.networks?.values?.length ?? 0) > 0
    readonly property bool isConnected: hasNetwork ? (currentNetworkDevice.connected ?? false) : false
    readonly property string networkName: isConnected ? (currentNetworkDevice.networks.values[0].name ?? "Disconnected") : "Disconnected"
    readonly property real networkConnectionStrength: isConnected ? currentNetworkDevice.networks.values[0].signalStrength : 0
    readonly property int networkConnectionType: hasNetwork ? currentNetworkDevice.type : -1
    readonly property string networkTypeString: hasNetwork ? DeviceType.toString(networkConnectionType) : ""

    Text {
        id: networkIcon
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Layout.bar.network.icon.fontSize ? Layout.bar.network.icon.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
        
        color: {
            if (parent.isConnected)
                return MatugenColors.colors.primary
            return MatugenColors.colors.error
        }

        text: {
            if (parent.networkTypeString == "Wifi") {
                if (parent.isConnected) {
                    if (parent.networkConnectionStrength >= 0.8)
                        return " 󰤨";
                    else if (parent.networkConnectionStrength >= 0.6)
                        return " 󰤥";
                    else if (parent.networkConnectionStrength >= 0.4)
                        return " 󰤢";
                    else if (parent.networkConnectionStrength >= 0.2)
                        return " 󰤟";
                    return " 󰤯";
                }
                return " 󰤮";
            }
            if (parent.networkTypeString == "Wired") {
                return " 󰈀";
            }
            return " 󰤮";
        }
    }

    Text {
        id: networkLabel
        anchors.verticalCenter: parent.verticalCenter
        color: MatugenColors.colors.surfaceOn
        font {
            family: Layout.bar.network.label.fontFamily ? Layout.bar.network.label.fontFamily : (Layout.bar.fontFamily ? Layout.bar.fontFamily : Layout.general.fontFamily)
            pixelSize: Layout.bar.network.label.fontSize ? Layout.bar.network.label.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
        }
        text: {
            if (networkMouseArea.hovered) {
                if (parent.networkTypeString == "Wired") {
                    return "Wired";
                }
                return parent.networkName;
            }
            return "";
        }
    }

    HoverHandler {
        id: networkMouseArea
        cursorShape: Qt.PointingHandCursor
    }

    Process {
        id: wifiTui

        command: ["kitty", "--class", "impala-wifi", "-e", "impala"]
    }

    TapHandler {
        gesturePolicy: TapHandler.ReleaseWithinBounds
        onTapped: wifiTui.running = true
    }
}