import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "ActivityIndicatorBarItem"

      // We only display the loading indicator while the timer is running
      rightBarItem: ActivityIndicatorBarItem {
        visible: timer.running
      }

      // Timer simulating a long running operation
      Timer {
        id: timer
        interval: 2000
      }

      AppButton {
        anchors.centerIn: parent
        text: "Long operation"
        onClicked: {
          timer.start()
        }
      }
    }
  }
}

