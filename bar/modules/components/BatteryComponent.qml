import QtQuick
import Quickshell.Services.UPower
import qs.theme

Row {
    id: batteryModule
    spacing: 8

    readonly property real capacity: (UPower.displayDevice?.percentage ?? 0) * 100
    readonly property bool isCharging: !UPower.onBattery

    visible: UPower.displayDevice?.isPresent ?? false

    Item {
        id: batteryIconWrapper
        implicitWidth: 12
        implicitHeight: 12
        anchors.verticalCenter: parent.verticalCenter

        Text {
            id: batteryIcon
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Layout.bar.battery.icon.fontSize ? Layout.bar.battery.icon.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)

            color: {
                if (batteryModule.capacity <= 20 && !batteryModule.isCharging)
                    return MatugenColors.colors.error
                return MatugenColors.colors.primary
            }
            
            text: {
                if (batteryModule.isCharging && batteryModule.capacity < 100)
                    return "";

                else if (batteryModule.capacity == 100)
                    return "󰁹";
                else if (batteryModule.capacity >= 90)
                    return "󰂂";
                else if (batteryModule.capacity >= 80)
                    return "󰂁";
                else if (batteryModule.capacity >= 70)
                    return "󰂀";
                else if (batteryModule.capacity >= 60)
                    return "󰁿";
                else if (batteryModule.capacity >= 50)
                    return "󰁾";
                else if (batteryModule.capacity >= 40)
                    return "󰁽";
                else if (batteryModule.capacity >= 30)
                    return "󰁼";
                else if (batteryModule.capacity >= 20)
                    return "󰁻";
                else if (batteryModule.capacity >= 10)
                    return "󰁺";
                    
                return "󰂃";
            }
        }
    }

    Text {
        id: batteryLabel
        anchors.verticalCenter: parent.verticalCenter
        color: MatugenColors.colors.surfaceOn
        font {
            family: Layout.bar.battery.label.fontFamily ? Layout.bar.battery.label.fontFamily : (Layout.bar.fontFamily ? Layout.bar.fontFamily : Layout.general.fontFamily)
            pixelSize: Layout.bar.battery.label.fontSize ? Layout.bar.battery.label.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
        }
        text: Math.round(batteryModule.capacity) + "% "
    }
}