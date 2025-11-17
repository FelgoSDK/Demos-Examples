import Felgo
import QtQuick
import QtCharts


App {
  readonly property var daysNumbers: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  readonly property int daysCount: daysNumbers.length
  readonly property var jackApples:  [2, 2, 3, 2, 4, 5, 3, 3, 2, 1]
  readonly property var jillApples:  [1, 2, 2, 3, 2, 3, 2, 1, 1, 2]

  readonly property var jackAndJillResults: jackApples.concat(jillApples)

  // Here we use ES6 spread operator "..."
  property int minApples: Math.min(...jackAndJillResults)
  property int maxApples: Math.max(...jackAndJillResults)

  readonly property color jackColor: "lightsalmon"
  readonly property color jillColor: "lightskyblue"
  readonly property string jackTitle: "Apples count Jack ate per day"
  readonly property string jillTitle: "Apples count Jill ate per day"

  Component.onCompleted: {
    for (var i = 0; i < daysCount; i++) {
      jackSeries.append( daysNumbers[i], jackApples[i] )
      jillSeries.append( daysNumbers[i], jillApples[i] )
    }
  }

  NavigationStack {
    AppPage {
      title: "LineSeries"

      ChartView {
        title: "Apples eaten per day"
        anchors.fill: parent
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
        antialiasing: true
        legend.alignment: Qt.AlignBottom

        // Define x-axis to be used with the series instead of default one
        ValueAxis {
          id: xAxis
          min: 1
          max: 10
          tickCount: 10
          labelFormat: "%.0f"
          titleText: "Day number"
        }

        ValueAxis {
          id: yAxis
          min: minApples - 1
          max: maxApples + 1
          titleText: "Amount of apples eaten"
        }

        LineSeries {
          id: jackSeries
          name: jackTitle
          color: jackColor
          axisX: xAxis
          axisY: yAxis
          width: 5
          capStyle: Qt.RoundCap
          pointsVisible: true
        }

        LineSeries {
          id: jillSeries
          name: jillTitle
          color: jillColor
          axisX: xAxis
          axisY: yAxis
          width: 5
          capStyle: Qt.RoundCap
          pointsVisible: true
        }
      }
    }
  }
}
