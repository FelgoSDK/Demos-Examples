import Felgo 4.0
import QtQuick 2.0
import QtCharts 2.0


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
      jackScatterSeries.append( daysNumbers[i], jackApples[i] )
      jillScatterSeries.append( daysNumbers[i], jillApples[i] )
    }
  }

  NavigationStack {
    AppPage {
      title: "ScatterSeries"

      ChartView {
        title: "Apples eaten per day"
        anchors.fill: parent
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
        antialiasing: true
        legend.alignment: Qt.AlignBottom

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

        ScatterSeries {
          id: jackScatterSeries
          name: jackTitle
          color: jackColor
          axisX: xAxis
          axisY: yAxis
          pointsVisible: true
          markerShape: ScatterSeries.MarkerShapeCircle
        }

        ScatterSeries {
          id: jillScatterSeries
          name: jillTitle
          color: jillColor
          axisX: xAxis
          axisY: yAxis
          pointsVisible: true
          markerShape: ScatterSeries.MarkerShapeRectangle
        }
      }
    }
  }
}
