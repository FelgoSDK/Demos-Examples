import Felgo 4.0
import QtQuick 2.0
import QtCharts 2.0


App {
  readonly property var daysNumbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  readonly property var jackApples:  [2, 2, 3, 2, 4, 5, 3, 3, 2, 1]
  readonly property var jillApples:  [1, 2, 2, 3, 2, 3, 2, 1, 1, 2]

  readonly property color jackColor: "lightsalmon"
  readonly property color jillColor: "lightskyblue"
  readonly property string jackTitle: "Apples count Jack ate per day"
  readonly property string jillTitle: "Apples count Jill ate per day"

  NavigationStack {
    AppPage {
      title: "HorizontalBarSeries"

      ChartView {
        title: "Apples eaten per day"
        anchors.fill: parent
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        HorizontalBarSeries {
          axisX: ValueAxis {
            labelFormat: "%.0f"
            titleText: "Apples count"
          }
          axisY: BarCategoryAxis {
            titleText: "Day number"
            categories: daysNumbers
          }

          BarSet {
            label: "Apples eaten by Jack"
            values: jackApples
            color: jackColor
          }

          BarSet {
            label: "Apples eaten by Jill"
            values: jillApples
            color: jillColor
          }
        }
      }
    }
  }
}
