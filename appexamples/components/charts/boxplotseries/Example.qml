import Felgo 4.0
import QtQuick 2.0
import QtCharts 2.0

App {
  NavigationStack {
    AppPage {
      title: "BoxPlotSeries"

      ChartView {
        anchors.fill: parent
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
        antialiasing: true
        legend.alignment: Qt.AlignBottom
        theme: ChartView.ChartThemeBrownSand

        BoxPlotSeries {
          id: plotSeries
          name: "Income"
          BoxSet {
            label: "Jan"
            values: [3, 4, 5.1, 6.2, 8.5]
          }
          BoxSet {
            label: "Feb"
            values: [5, 6, 7.5, 8.6, 11.8]
          }
          BoxSet {
            label: "Mar"
            values: [3.2, 5, 5.7, 8, 9.2]
          }
          BoxSet {
            label: "Apr"
            values: [3.8, 5, 6.4, 7, 8]
          }
          BoxSet {
            label: "May"
            values: [4, 5, 5.2, 6, 7]
          }
        }
      }
    }
  }
}
