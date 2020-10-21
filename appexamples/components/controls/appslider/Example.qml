import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "AppSlider"

      Column {
        anchors.centerIn: parent

        AppSlider {
          id: slider
          width: page.width * 0.6
        }

        // Display text with slider position
        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Position: " + Math.round(slider.position * 100)
        }
      }
    }
  }
}
