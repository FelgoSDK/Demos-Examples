import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "VisibilityRefreshHandler"

      // Display a refresh icon as the top right icon
      rightBarItem: ActivityIndicatorBarItem {
        animating: delayTimer.running
        visible: animating
      }

      // We use a timer to simulate long loading operation
      Timer {
        id: delayTimer
        interval: 2000
        onTriggered: {
          // On triggered we just add new items to the model
          // and preserve the scroll position
          var pos = listView.getScrollPosition()
          listView.model += 5
          listView.restoreScrollPosition(pos)
        }
      }

      AppListView {
        id: listView

        model: 20
        anchors.fill: parent

        delegate: SimpleRow {
          text: index
        }

        footer: VisibilityRefreshHandler {
          onRefresh: {
            delayTimer.start()
          }
        }
      }
    }
  }
}
