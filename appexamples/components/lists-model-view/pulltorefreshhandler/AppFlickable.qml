import QtQuick 2.8
import Felgo 4.0

App {
  NavigationStack {
    AppPage {
      title: "Pull to refresh"

      rightBarItem: ActivityIndicatorBarItem {
        visible: refreshSimulator.running
      }

      Timer {
        id: refreshSimulator
        interval: 1500
      }

      AppFlickable {
        id: flickable
        anchors.fill: parent
        contentWidth: width
        contentHeight: column.height

        Column {
          id: column
          width: parent.width

          Repeater {
            model: 30
            AppListItem {
              text: "Item " + index
            }
          }
        }

        PullToRefreshHandler {
          listView: flickable
          onRefresh: {
            refreshSimulator.restart()
          }
        }
      }
    }
  }
}
