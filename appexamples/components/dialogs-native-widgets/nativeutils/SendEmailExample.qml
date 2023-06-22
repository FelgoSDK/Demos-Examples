import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "Send Mail"

      AppButton {
        flat: false
        text: "Send Mail"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.sendEmail("", "Check this out!", "https://felgo.com")
        }
      }
    }
  }
}
