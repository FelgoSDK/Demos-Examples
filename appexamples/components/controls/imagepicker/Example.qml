import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "ImagePicker"

      rightBarItem: TextButtonBarItem {
        text: "Next"
        enabled: imagePicker.selectedCount > 0

        // App will pop the photo selection page from the stack to move on
        // this example only logs the selected photos
        onClicked: {
          console.debug("SELECTED:", JSON.stringify(imagePicker.selection))
        }
      }

      // Image picker view for photo selection
      ImagePicker {
        id: imagePicker
        anchors.fill: parent

        // Uncomment to use top-to-bottom flow with horizontal scrolling
        // flow: ImagePicker.FlowTopToBottom
      }
    }
  }
}
