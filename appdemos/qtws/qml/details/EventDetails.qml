import QtQuick

QtObject {
  readonly property string id: "qtworldsummit"
  readonly property string name: "Qt World Summit 23"
  readonly property string shortName: "QtWS23"
  readonly property string genericName: "QtWS"
  readonly property string shortInfo: "Berlin, Germany / November 28th - 29th"

  readonly property string timeZone: "+0100"
  readonly property int timeZoneOffset: 1
  readonly property date startDate: "2023-11-28T08:30.000" + timeZone
  readonly property date endDate: "2023-11-29T16:00.000" + timeZone

  readonly property color neonColor: "#2CDE85"
  readonly property color violetColor: "#CDB0FF"
  readonly property color lemonColor: "#DBEB00"
  readonly property color pineColor: "#002125"
  readonly property color lightPineColor: Qt.lighter(pineColor, 1.5)
  readonly property color mossColor: "#373f27"
  readonly property color mandarinColor: "#FFA629"
  readonly property color blueColor: "#1D68D0"
}
