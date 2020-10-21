import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "PullToRefreshHandler"

      // Display a refresh icon as the top right icon
      rightBarItem: IconButtonBarItem {
        icon: IconType.refresh
        onClicked: {
          delayTimer.start()
        }
      }

      // We use a timer to simulate long loading operation
      Timer {
        id: delayTimer
        interval: 2000
        onTriggered: {
          // On triggered we just add a new item to the model
          listView.model += 1
        }
      }

      AppListView {
        id: listView

        model: 5
        anchors.fill: parent

        delegate: SimpleRow {
          text: index
        }

        footer: VisibilityRefreshHandler {
          visible: delayTimer.running
        }
      }
    }
  }
}
