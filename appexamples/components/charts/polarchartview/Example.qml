import Felgo 3.0
import QtQuick 2.0
import QtCharts 2.0

App {
  NavigationStack {
    Page {
      title: "PolarChartView"

      ChartView {
        anchors.fill: parent
        antialiasing: true
        legend.alignment: Qt.AlignBottom
        theme: ChartView.ChartThemeBrownSand

        PolarChartView {
          title: "Two Series, Common Axes"
          anchors.fill: parent
          legend.visible: false
          antialiasing: true

          ValueAxis {
            id: axisAngular
            min: 0
            max: 20
            tickCount: 9
          }

          ValueAxis {
            id: axisRadial
            min: -0.5
            max: 1.5
          }

          SplineSeries {
            id: series1
            axisAngular: axisAngular
            axisRadial: axisRadial
            pointsVisible: true
          }

          ScatterSeries {
            id: series2
            axisAngular: axisAngular
            axisRadial: axisRadial
            markerSize: 10
          }
        }

        // Add data dynamically to the series
        Component.onCompleted: {
          for (var i = 0; i <= 20; i++) {
            series1.append(i, Math.random())
            series2.append(i, Math.random())
          }
        }
      }
    }
  }
}
