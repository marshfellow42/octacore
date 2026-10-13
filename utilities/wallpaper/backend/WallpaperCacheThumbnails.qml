import QtQuick
import Quickshell
import Quickshell.Io

Item {
    property string importFilePath
    property string importCacheFilePath
    property string thumbCacheBaseDir: (Quickshell.env("XDG_CACHE_HOME") || (Quickshell.env("HOME") + "/.cache")) + "/quickshell/thumbs"

    FileView {
        id: cacheCheck
        
        path: importCacheFilePath
        preload: false
    }

    Process {
        id: ensureDir
        command: ["mkdir", "-p", thumbCacheBaseDir]
        running: !cacheCheck.loaded
        onExited: (exitCode, exitStatus) => {
            if (exitCode === 0) {
                vipsCache.running = true
            }
        }
    }

    Process {
        id: vipsCache
        command: ["vipsthumbnail", "--size", "640", "--output-profile", "srgb", "-o", thumbCacheBaseDir + "/%s.jpg[Q=75,optimize_coding,keep=none]", importFilePath]
        running: false
    }
}