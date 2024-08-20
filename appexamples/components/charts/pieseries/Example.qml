import Felgo 4.0
import QtQuick 2.0
import QtCharts 2.0


App {
  id: app

  readonly property var daysNumbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  readonly property int daysCount: daysNumbers.length
  readonly property var jackApples:  [2, 2, 3, 2, 4, 5, 3, 3, 2, 1]
  readonly property var jillApples:  [1, 2, 2, 3, 2, 3, 2, 1, 1, 2]

  readonly property color jackColor: "lightsalmon"
  readonly property color jillColor: "lightskyblue"
  readonly property string jackTitle: "Apples count Jack ate per day"
  readonly property string jillTitle: "Apples count Jill ate per day"

  NavigationStack {
    AppPage {
      title: "PieSeries"

      ChartView {
        title: "Tatal number of apples eaten " + pieSeries.sum
        anchors.fill: parent
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        PieSeries {
          id: pieSeries

          PieSlice {
            label: "Apples eaten by Jack: " + value
            // Value is a number (sum of all elements of array)
            value: jackApples.reduce( (acc, current) => acc + current, 0)
            color: jackColor
            labelVisible: true
          }

          PieSlice {
            label: "Apples eaten by Jill: " + value
            value: jillApples.reduce( (acc, current) => acc + current, 0)
            color: jillColor
            labelVisible: true
          }
        }
      }
    }
  }
}
