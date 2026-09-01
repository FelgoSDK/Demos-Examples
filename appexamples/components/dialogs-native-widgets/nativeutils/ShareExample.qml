import Felgo


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
