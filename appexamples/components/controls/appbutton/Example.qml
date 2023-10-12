import QtQuick 2.0
import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "AppButton"

      Column {
        anchors.centerIn: parent

        AppButton {
          text: "Flat button"
          flat: true
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: console.log("Flat button clicked!")
        }

        AppButton {
          text: "Raised button"
          flat: false
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: console.log("Raised button clicked!")
        }

        AppButton {
          text: "Disabled button"
          enabled: false
          anchors.horizontalCenter: parent.horizontalCenter
        }

        AppButton {
          text: "Bold text and some radius"
          fontBold: true
          radius: dp(20)
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: console.log("Special button clicked!")
        }
      }
    }
  }
}
