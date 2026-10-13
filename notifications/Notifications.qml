pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
    id: root

    // Exposed so any UI component can bind to it
    property alias trackedNotifications: notificationServer.trackedNotifications

    NotificationServer {
        id: notificationServer

        bodySupported: true
        actionsSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: notification => {
            notification.tracked = true;
        }
    }
}