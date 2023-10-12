import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "Share"

      AppButton {
        flat: false
        text: "Share"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.share("Check this out!", "https://felgo.com")
        }
      }
    }
  }
}
