import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.theme

Rectangle {
    id: root

    implicitWidth: contentLayout.width + 30
    implicitHeight: contentLayout.height + 20
    color: MatugenColors.colors.surfaceContainerLowest
    radius: Layout.barCornerRadius

    readonly property var obsTrayItem: {
        const items = SystemTray.items.values

        for (let i = 0; i < items.length; i++) {
            const it = items[i]

            if (!it)
                continue
            
            const title = (it.title ?? "").toLowerCase()
            
            const id = (it.id ?? "").toLowerCase()
            
            if (title.includes("obs") || id.includes("obs")) {
                return it
            }
        }
        
        return null
    }

    visible: obsTrayItem !== null

    Item {
        id: contentLayout
        anchors.centerIn: parent
        width: obsIcon.implicitWidth
        height: obsIcon.implicitHeight

        IconImage {
            id: obsIcon
            implicitSize: 18

            source: root.obsTrayItem ? root.obsTrayItem.icon : ""
            asynchronous: true
        }

    }
}