import Felgo 4.0


App {
  NavigationStack {
    AppPage {
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
