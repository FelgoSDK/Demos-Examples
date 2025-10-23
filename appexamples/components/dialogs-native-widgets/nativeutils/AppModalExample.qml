import Felgo


App {
  NavigationStack {
    id: navigationStack
    AppPage {
      title: "AppModal"
      AppButton {
        anchors.centerIn: parent
        text: "Open AppModal"
        onClicked: modal.open()
      }

      AppModal {
        id: modal
        // Set your main content root item
        pushBackContent: navigationStack

        // Button to open the modal
        AppButton {
          text: "Close"
          anchors.centerIn: parent
          onClicked: modal.close()
        }
      }
    }
  }
}
