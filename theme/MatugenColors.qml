pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property alias colors: adapter

    FileView {
        path: Quickshell.env("HOME") + "/.cache/matugen/colors_quickshell.json"
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter

            property string primary: "#000000"
            property string primaryOn: "#000000"
            property string primaryContainer: "#000000"
            property string primaryContainerOn: "#000000"
            property string primaryFixed: "#000000"
            property string primaryFixedDim: "#000000"
            property string primaryFixedOn: "#000000"
            property string primaryFixedVariantOn: "#000000"
            property string inversePrimary: "#000000"

            property string secondary: "#000000"
            property string secondaryOn: "#000000"
            property string secondaryContainer: "#000000"
            property string secondaryContainerOn: "#000000"
            property string secondaryFixed: "#000000"
            property string secondaryFixedDim: "#000000"
            property string secondaryFixedOn: "#000000"
            property string secondaryFixedVariantOn: "#000000"

            property string tertiary: "#000000"
            property string tertiaryOn: "#000000"
            property string tertiaryContainer: "#000000"
            property string tertiaryContainerOn: "#000000"
            property string tertiaryFixed: "#000000"
            property string tertiaryFixedDim: "#000000"
            property string tertiaryFixedOn: "#000000"
            property string tertiaryFixedVariantOn: "#000000"

            property string error: "#000000"
            property string errorOn: "#000000"
            property string errorContainer: "#000000"
            property string errorContainerOn: "#000000"

            property string background: "#000000"
            property string backgroundOn: "#000000"

            property string surface: "#000000"
            property string surfaceOn: "#000000"
            property string surfaceVariant: "#000000"
            property string surfaceVariantOn: "#000000"
            property string surfaceDim: "#000000"
            property string surfaceBright: "#000000"
            property string surfaceContainerLowest: "#000000"
            property string surfaceContainerLow: "#000000"
            property string surfaceContainer: "#000000"
            property string surfaceContainerHigh: "#000000"
            property string surfaceContainerHighest: "#000000"
            property string inverseSurface: "#000000"
            property string inverseOnSurface: "#000000"

            property string outline: "#000000"
            property string outlineVariant: "#000000"
            property string shadow: "#000000"
            property string scrim: "#000000"
            property string surfaceTint: "#000000"
            property string sourceColor: "#000000"
        }
    }
}