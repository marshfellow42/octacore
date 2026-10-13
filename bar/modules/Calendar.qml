import QtQuick
import Quickshell
import qs.theme
import qs.bar.widgets.calendar

Item {
    id: root

    implicitWidth: visualPill.implicitWidth
    implicitHeight: visualPill.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Rectangle {
        id: visualPill
        anchors.centerIn: parent

        implicitWidth: timeLabel.implicitWidth + 30
        implicitHeight: timeLabel.implicitHeight + 18
        radius: Layout.barCornerRadius

        color: MatugenColors.colors.surfaceContainerLowest

        // Tamed: Only scales down slightly when physically clicked
        scale: pillMouse.pressed ? 0.95 : 1.0

        // Snappy, non-bouncy transitions
        Behavior on scale {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }

        MouseArea {
            id: pillMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: calendarWidget.visible = !calendarWidget.visible
        }

        Text {
            id: timeLabel
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, " hh:mm:ss  •  dd/MM/yyyy ")

            color: MatugenColors.colors.surfaceOn

            font {
                family: "Google Sans Medium"
                pixelSize: 16
            }
        }
    }

    CalendarWidget {
        id: calendarWidget
        visible: false
    }
}
