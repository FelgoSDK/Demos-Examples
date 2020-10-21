import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "Dialog"

      AppButton {
        anchors.centerIn: parent
        text: "Custom Dialog"
        flat: true
        onClicked: {
          customDialog.open()
        }
      }

      Dialog {
        id: customDialog
        title: "Do you think this is awesome?"
        positiveActionLabel: "Yes"
        negativeActionLabel: "No"
        onCanceled: {
          title = "Think again!"
        }
        onAccepted: {
          close()
        }

        AppImage {
          // Will be placed inside the dialogs content area
          anchors {
            fill: parent
            margins: dp(Theme.contentPadding)
          }
          source: "https://picsum.photos/200"
          fillMode: Image.PreserveAspectFit
        }
      }
    }
  }
}
