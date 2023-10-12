import QtQuick 2.0
import Felgo 3.0


App {
  NavigationStack {
    Page {
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
