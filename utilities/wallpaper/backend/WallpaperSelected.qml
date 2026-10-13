import QtQuick
import Quickshell
import Quickshell.Io

Item {
    property string wallFile

    onWallFileChanged: {
        let file = wallFile;
        awwwProc.command = ["awww", "img", "--transition-type", "center", "--transition-duration", "2", file];
        matugenProc.command = ["matugen", "image", file, "--source-color-index", "0"];
        awwwProc.startDetached();
        matugenProc.startDetached();
    }

    Process {
        id: awwwProc
    }

    Process {
        id: matugenProc
    }

    Process {
        id: hyprProc

        command: ["hyprctl", "reload"]
        running: true
    }

}
