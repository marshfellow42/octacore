import QtQuick
import Quickshell.Services.Pipewire
import qs.theme

// --- Audio Module ---
Row {
    id: volumeModule
    spacing: 8

    // --- Audio State Management ---
    readonly property var activeSink: Pipewire.defaultAudioSink
    readonly property bool isMuted: activeSink?.audio?.muted ?? true
    readonly property real volumeLevel: activeSink?.audio?.volume ?? 0.0

    // Ensures Pipewire sink stays reactive to external system changes.
    PwObjectTracker {
        objects: parent.activeSink ? [parent.activeSink] : []
    }

    Item {
        id: volumeModuleIconWrapper
        implicitWidth: 12
        implicitHeight: 12
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: volumeModuleIcon
            anchors.centerIn: parent
            font.pixelSize: Layout.bar.volume.icon.fontSize ? Layout.bar.volume.icon.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
            
            color: {
                if (volumeModule.isMuted)
                    return MatugenColors.colors.error
                return MatugenColors.colors.primary
            }

            text: {
                if (!volumeModule.activeSink?.audio)
                    return "󰸈"; // No device
                else if (volumeModule.isMuted)
                    return "󰝟";
                else if (volumeModule.volumeLevel > 0.5)
                    return "󰕾"; // High
                else if (volumeModule.volumeLevel > 0)
                    return "󰖀"; // Mid
                return "󰕿";
            }
        }
    }

    Text {
        id: volumeLabel
        anchors.verticalCenter: parent.verticalCenter
        color: MatugenColors.colors.surfaceOn
        font {
            family: Layout.bar.volume.label.fontFamily ? Layout.bar.volume.label.fontFamily : (Layout.bar.fontFamily ? Layout.bar.fontFamily : Layout.general.fontFamily)
            pixelSize: Layout.bar.volume.label.fontSize ? Layout.bar.volume.label.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
        }
        text: parent.activeSink?.audio ? Math.round(parent.volumeLevel * 100) + "%" : "--%"
    }

    HoverHandler {
        id: audioMouseArea
        cursorShape: Qt.PointingHandCursor
    }

    // A handler to mute or unmute the volume with a mouse click
    TapHandler {
        gesturePolicy: TapHandler.ReleaseWithinBounds
        onTapped: {
            if (parent.activeSink?.audio) {
                parent.activeSink.audio.muted = !parent.isMuted
            }
        }
    }

    // A handler to raise or lower the volume with the mouse scroll wheel
    WheelHandler {
        id: audioRotationArea
        rotationScale: 0.05
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: (event) => {
            if (!parent.activeSink?.audio) return;

            // Determine scroll direction (positive or negative steps)
            let step = event.angleDelta.y > 0 ? rotationScale : -rotationScale;
            
            // Calculate new volume bound between 0.0 and 1.0
            let newVolume = Math.min(1.0, Math.max(0.0, parent.volumeLevel + step));
            
            parent.activeSink.audio.volume = newVolume;
        }
    }
}