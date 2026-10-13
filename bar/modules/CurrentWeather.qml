import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.theme

Rectangle {
    id: root

    implicitWidth: contentLayout.width + 30
    implicitHeight: contentLayout.height + 20
    color: MatugenColors.colors.surfaceContainerLowest
    radius: Layout.barCornerRadius

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    property string currentMoonPhaseName: ""
    property string currentTemp: ""
    property string currentCondition: ""
    property string currentWeatherCode: ""

    property int weatherExitCode: 1

    visible: weatherExitCode === 0

    function weatherConditionEmoji(weatherCode) {
        const weather = {
            "113": "☀️", // Sunny
            "116": "⛅", // PartlyCloudy
            "119": "☁️", // Cloudy
            "122": "☁️", // VeryCloudy
            "143": "🌫️", // Fog
            "176": "🌦️", // LightShowers
            "179": "🌧️", // LightSleetShowers
            "182": "🌧️", // LightSleet
            "185": "🌧️", // LightSleet
            "200": "⛈️", // ThunderyShowers
            "227": "🌨️", // LightSnow
            "230": "❄️", // HeavySnow
            "248": "🌫️", // Fog
            "260": "🌫️", // Fog
            "263": "🌦️", // LightShowers
            "266": "🌦️", // LightRain
            "281": "🌧️", // LightSleet
            "284": "🌧️", // LightSleet
            "293": "🌦️", // LightRain
            "296": "🌦️", // LightRain
            "299": "🌧️", // HeavyShowers
            "302": "🌧️", // HeavyRain
            "305": "🌧️", // HeavyShowers
            "308": "🌧️", // HeavyRain
            "311": "🌧️", // LightSleet
            "314": "🌧️", // LightSleet
            "317": "🌧️", // LightSleet
            "320": "🌨️", // LightSnow
            "323": "🌨️", // LightSnowShowers
            "326": "🌨️", // LightSnowShowers
            "329": "❄️", // HeavySnow
            "332": "❄️", // HeavySnow
            "335": "❄️", // HeavySnowShowers
            "338": "❄️", // HeavySnow
            "350": "🌧️", // LightSleet
            "353": "🌦️", // LightShowers
            "356": "🌧️", // HeavyShowers
            "359": "🌧️", // HeavyRain
            "362": "🌧️", // LightSleetShowers
            "365": "🌧️", // LightSleetShowers
            "368": "🌨️", // LightSnowShowers
            "371": "❄️", // HeavySnowShowers
            "374": "🌧️", // LightSleetShowers
            "377": "🌧️", // LightSleet
            "386": "⛈️", // ThunderyShowers
            "389": "🌩️", // ThunderyHeavyRain
            "392": "⛈️", // ThunderySnowShowers
            "395": "❄️", // HeavySnowShowers
        }
        return weather[weatherCode] || "✨"
    }

    function moonPhaseEmoji(phaseName) {
        const phases = {
            "New Moon": "🌑",
            "Waxing Crescent": "🌒",
            "First Quarter": "🌓",
            "Waxing Gibbous": "🌔",
            "Full Moon": "🌕",
            "Waning Gibbous": "🌖",
            "Last Quarter": "🌗",
            "Waning Crescent": "🌘"
        }
        return phases[phaseName] || "🌙"
    }

    Item {
        id: contentLayout
        anchors.centerIn: parent
        width: weatherRow.implicitWidth
        height: weatherRow.implicitHeight

        Process {
            id: currentWeatherAPI

            command: ["curl", "-s", "wttr.is/?format=j1"]

            stdout: StdioCollector {
                onStreamFinished: {
                    try {
                        const data = JSON.parse(this.text)

                        root.currentMoonPhaseName = data.weather[0].astronomy[0].moon_phase
                        root.currentTemp = data.current_condition[0].temp_C + "°C"
                        root.currentCondition = data.current_condition[0].weatherDesc[0].value
                        root.currentWeatherCode = data.current_condition[0].weatherCode
                    } catch (e) {
                        console.log("Failed to parse weather JSON:", e)
                    }
                }
            }

            onExited: (exitCode) => { weatherExitCode = exitCode }
        }

        Timer {
            id: weatherTimer
            interval: 30 * 60 * 1000   // 30 minutes in ms
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: currentWeatherAPI.running = true
        }

        HoverHandler {
            id: weatherMouseArea
        }

        Row {
            id: weatherRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 6

            Text {
                id: weatherIcon
                anchors.verticalCenter: parent.verticalCenter
                color: MatugenColors.colors.surfaceOn
                font.pixelSize: Layout.bar.weather.icon.fontSize ? Layout.bar.weather.icon.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
                text: {
                    const isNight = (clock.hours <= 5) || (clock.hours >= 18)
                    return isNight ? root.moonPhaseEmoji(root.currentMoonPhaseName) : root.weatherConditionEmoji(root.currentWeatherCode)
                }
            }

            Text {
                id: currentMoonPhase
                anchors.verticalCenter: parent.verticalCenter
                color: MatugenColors.colors.surfaceOn
                font.pixelSize: Layout.bar.weather.icon.fontSize ? Layout.bar.weather.icon.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
                text: {
                    const isNight = (clock.hours <= 5) || (clock.hours >= 18)
                    if (weatherMouseArea.hovered && isNight) {
                        return root.currentMoonPhaseName
                    }
                    return ""
                }
            }

            Text {
                id: currentWeather
                anchors.verticalCenter: parent.verticalCenter
                color: MatugenColors.colors.surfaceOn
                font {
                    family: Layout.bar.weather.icon.fontFamily ? Layout.bar.weather.icon.fontFamily : (Layout.bar.fontFamily ? Layout.bar.fontFamily : Layout.general.fontFamily)
                    pixelSize: Layout.bar.weather.label.fontSize ? Layout.bar.weather.label.fontSize : (Layout.bar.fontSize ? Layout.bar.fontSize : Layout.general.fontSize)
                }
                text: root.currentTemp
            }
        }
    }
}