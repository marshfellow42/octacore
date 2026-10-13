pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias general: adapter.general
    property alias bar: adapter.bar
    property alias notifications: adapter.notifications

    readonly property int barCornerRadius: adapter.bar.cornerRadius >= 0 ? adapter.bar.cornerRadius : adapter.general.cornerRadius
    readonly property string barFontFamily: adapter.bar.fontFamily !== "" ? adapter.bar.fontFamily : adapter.general.fontFamily
    readonly property int barFontSize: adapter.bar.fontSize >= 1 ? adapter.bar.fontSize : adapter.general.fontSize
    readonly property string notificationsFontFamily: adapter.notifications.fontFamily !== "" ? adapter.notifications.fontFamily : adapter.general.fontFamily

    FileView {
        path: Quickshell.shellPath("config.json")
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter

            property JsonObject general: JsonObject {
                property string fontFamily: "JetBrains Mono Nerd Font"
                property int fontSize: 16
                property string locale: "en"
                property int cornerRadius: 100
            }

            property JsonObject bar: JsonObject {
                property string fontFamily: ""
                property int fontSize: 0
                property int height: 60
                property int bottomMargin: -15
                property int cornerRadius: -1
                property JsonObject workspaces: JsonObject {
                    property string fontFamily: ""
                    property int fontSize: 0
                }
                property JsonObject music: JsonObject {
                    property JsonObject icon: JsonObject {
                        property int fontSize: 0
                    }
                    property JsonObject label: JsonObject {
                        property string fontFamily: ""
                        property int fontSize: 0
                    }
                }
                property JsonObject weather: JsonObject {
                    property JsonObject icon: JsonObject {
                        property int fontSize: 0
                    }
                    property JsonObject label: JsonObject {
                        property string fontFamily: ""
                        property int fontSize: 0
                    }
                }
                property JsonObject network: JsonObject {
                    property JsonObject icon: JsonObject {
                        property int fontSize: 0
                    }
                    property JsonObject label: JsonObject {
                        property string fontFamily: ""
                        property int fontSize: 0
                    }
                }
                property JsonObject volume: JsonObject {
                    property JsonObject icon: JsonObject {
                        property int fontSize: 0
                    }
                    property JsonObject label: JsonObject {
                        property string fontFamily: ""
                        property int fontSize: 0
                    }
                }
                property JsonObject battery: JsonObject {
                    property JsonObject icon: JsonObject {
                        property int fontSize: 0
                    }
                    property JsonObject label: JsonObject {
                        property string fontFamily: ""
                        property int fontSize: 0
                    }
                }
                property JsonObject clock: JsonObject {
                    property string fontFamily: ""
                    property int  fontSize: 0
                }
            }

            property JsonObject notifications: JsonObject {
                property string fontFamily: ""
                property int timeout: 5000 // ms
                property int headingFontSize: 14
                property int contentFontSize: 12
            }

            property JsonObject popups: JsonObject {
                property JsonObject volumePopup: JsonObject {
                    property string fontFamily: ""
                    property int timeout: 5000 // ms
                }
                property JsonObject brightnessPopup: JsonObject {
                    property string fontFamily: ""
                    property int timeout: 5000 // ms
                }
            }
        }
    }
}