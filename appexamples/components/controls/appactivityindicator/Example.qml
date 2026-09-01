import QtQuick
import Felgo

App {
  NavigationStack {
    AppPage {
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
