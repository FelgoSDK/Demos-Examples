import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "AppRangeSlider"

      Column {
        anchors.centerIn: parent

        AppRangeSlider {
          id: slider
          width: page.width * 0.6
        }

        // Display text with slider position
        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Position: " + Math.round(slider.first.position * 100)
                + " - " + Math.round(slider.second.position * 100)
        }
      }
    }
  }
}
