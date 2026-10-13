import QtQuick
import Quickshell
import qs.bar
import qs.utilities.launcher
import qs.utilities.wallpaper
import qs.popups
import qs.notifications

/** Main shell entry point; manages surface orchestration. */
ShellRoot {
    id: root

    TopBar {
        id: topBar
    }

    NotificationPopup {
        id: notificationPopup
    }

    // Application Launcher
    Launcher {
        id: launcherWindow
    }

    Wallpaper {
        id: wallpaperWindow
    }

    VolumePopup {
        id: volumePopupWindow
    }

    BrightnessPopup {
        id: brightnessPopupWindow
    }
}
