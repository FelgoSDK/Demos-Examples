import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "Alert Dialog"

      AppButton {
        flat: false
        text: "Alert Dialog"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.displayAlertDialog("Hello!", "I'm an alert dialog", "Ok", "Cancel")
        }
      }
    }
  }
}
