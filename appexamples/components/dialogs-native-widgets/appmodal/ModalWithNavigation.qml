import QtQuick
import Felgo


App {
  // Set the background of the app to black (for the default iOS modal)
  color: "black"

  NavigationStack {
    id: navigationStack

    AppPage {
      title: "AppModal"

      Column {
        anchors.centerIn: parent

        AppButton {
          text: "Open Modal"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            modal.open()
          }
        }

        // Button to change the platform
        AppButton {
          text: "Platform: " + Theme.platform
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            Theme.platform = Theme.platform == "ios" ? "android" : "ios"
            Theme.colors.statusBarStyle = Theme.platform == "ios"
                ? Theme.colors.statusBarStyleBlack
                : Theme.colors.statusBarStyleWhite
          }
        }
      }

      AppModal {
        id: modal
        // Set main content root item
        pushBackContent: navigationStack

        // Add any custom content for the modal
        NavigationStack {
          AppPage {
            title: "Modal"
            rightBarItem: TextButtonBarItem {
              text: "Close"
              textItem.font.pixelSize: sp(16)
              onClicked: {
                modal.close()
              }
            }
          }
        }
      }
    }
  }
}
