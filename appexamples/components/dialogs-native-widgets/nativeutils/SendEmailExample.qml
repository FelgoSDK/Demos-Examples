import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "Send Mail"

      AppButton {
        flat: false
        text: "Send Mail"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.send("Check this out!", "https://felgo.com")
        }
      }
    }
  }
}
