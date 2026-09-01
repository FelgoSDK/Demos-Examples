import QtQuick
import Felgo


App {
  // Set the background of the app to black (for the default iOS modal)
  color: "black"

  NavigationStack {
    id: navigationStack

    AppPage {
      title: "AppModal"

      // Button to open the modal
      AppButton {
        text: "Open Modal"
        anchors.centerIn: parent
        onClicked: {
          modal.open()
        }
      }

      AppModal {
        id: modal
        // Set main content root item
        pushBackContent: navigationStack
        // Disable fullscreen to use as partial modal
        fullscreen: false
        // Set a custom height for the modal
        modalHeight: dp(300)

        // Button to open the modal
        AppButton {
          text: "Close"
          anchors.centerIn: parent
          onClicked: {
            modal.close()
          }
        }
      }
    }
  }
}
