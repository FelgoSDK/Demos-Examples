import Felgo 4.0


App {
  NavigationStack {
    AppPage {
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
