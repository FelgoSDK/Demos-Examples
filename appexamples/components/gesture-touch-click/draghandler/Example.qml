import Felgo 3.0
// Draghandler is available starting QtQuick 2.12
import QtQuick 2.12


App {
  NavigationStack {
    Page {
      id: page
      title: "DragHandler"

      Rectangle {
        // Let's position the red square at the center of the top half screen
        x: (parent.width - width) / 2
        y: (parent.height - height) / 4

        width: dp(100)
        height: dp(100)

        color: "cornflowerblue"
        z: 1

        DragHandler {
          // Allow movement on both axis
          xAxis.enabled: true
          yAxis.enabled: true

          // You can't move it outside of the top half
          xAxis.minimum: 0
          xAxis.maximum: page.width - parent.width
          yAxis.minimum: 0
          yAxis.maximum: page.height / 2 - parent.height
        }
      }

      AppText {
        anchors {
          margins: Theme.contentPadding
          bottom: parent.bottom
          bottomMargin: parent.height / 2 - Theme.contentPadding - height
          horizontalCenter: parent.horizontalCenter
        }
        text: "You can't move the square here"
      }
    }
  }
}
