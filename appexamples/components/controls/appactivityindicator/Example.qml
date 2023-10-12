import QtQuick 2.0
import Felgo 3.0

App {
  NavigationStack {
    Page {
      title: "AppActivityIndicator"

      Column {
        anchors.centerIn: parent
        AppButton {
          text: enabled ? "Start job" : "Running..."
          enabled: !job.running
          onClicked: job.start()
        }

        AppActivityIndicator {
          animating: job.running
          anchors.horizontalCenter: parent.horizontalCenter
        }
      }
    }
  }

  Timer {
    id: job
    interval: 2000
    onTriggered: console.log("Job finished")
  }
}
