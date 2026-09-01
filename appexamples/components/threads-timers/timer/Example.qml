import QtQuick
import Felgo


App {
  NavigationStack {
    AppPage {
      title: "Timer"

      Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
          timeLabel.text = Date().toString()
        }
      }

      AppText {
        id: timeLabel
        anchors.centerIn: parent
      }
    }
  }
}
