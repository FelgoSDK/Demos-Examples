import Felgo 4.0
import QtQuick 2.0

import "charts"

App {
  id: app

  property bool enable3DView: false
  property var chartData: []

  // load data from C++ at app startup
  Component.onCompleted: cppDataModel.loadData()

  // when new data is sent from C++, parse the JSON and use as chartData in QML
  Connections {
    target: cppDataModel
    // the dataLoaded signal provides a jsonDataString parameter
    onDataLoaded: jsonDataString => chartData = JSON.parse(jsonDataString)
  }

  // UI code starts here
  NavigationStack {
    initialPage: AppPage {
      title: "Chart Example"

      BarChart2D {
        id: barChart2D
        visible: !enable3DView
      }

    } // AppPage
  } // NavigationStack
} // App
