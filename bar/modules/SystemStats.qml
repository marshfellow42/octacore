import QtQuick
import qs.theme
import qs.bar.modules.components

/**
 * A unified system status indicator for Internet, Audio (Pipewire) and Power (UPower).
 */
Rectangle {
    id: root

    // --- Layout Configuration ---
    implicitWidth: contentLayout.width + 30
    implicitHeight: contentLayout.height + 18
    color: MatugenColors.colors.surfaceContainerLowest
    radius: Layout.barCornerRadius

    Row {
        id: contentLayout

        anchors.centerIn: parent
        spacing: 16

        NetworkComponent {
            id: networkComponent
        }

        // --- Separator ---
        Rectangle {
            width: 1
            height: 16
            color: MatugenColors.colors.outline
            anchors.verticalCenter: parent.verticalCenter
        }

        VolumeComponent {
            id: volumeComponent
        }

        // --- Separator ---
        Rectangle {
            visible: batteryComponent.isVisible
            width: 1
            height: 16
            color: MatugenColors.colors.outline
            anchors.verticalCenter: parent.verticalCenter
        }

        BatteryComponent {
            id: batteryComponent
        }

    }

}
