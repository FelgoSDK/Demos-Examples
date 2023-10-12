import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    Page {
      title: "AppTabBar"

      // Tabs
      AppTabBar {
        id: appTabBar
        contentContainer: swipeView

        AppTabButton {
          text: "Coral"
        }

        AppTabButton {
          text: "Green"
        }
      }

      // Tabs contents
      QC2.SwipeView {
        id: swipeView
        anchors {
          top: appTabBar.bottom
          bottom: parent.bottom
        }
        width: parent.width
        clip: true

        Rectangle {
          color: "Coral"
        }

        Rectangle {
          color: "Green"
        }
      }
    }
  }
}
