import QtQuick 2.0
import Felgo 4.0


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
