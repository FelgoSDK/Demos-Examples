import Felgo
import QtQuick
import QtQuick.Controls as QC2


App {
  NavigationStack {
    AppPage {
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
