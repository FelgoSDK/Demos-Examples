import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "Column"

      Column {
        // Lay items with a bit more space
        spacing: dp(16)
        anchors.centerIn: parent

        AppText {
          // Here we force the text to be horizontally centered in the column
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Top text"
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Middle button"
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Bottom text"
        }
      }
    }
  }
}
