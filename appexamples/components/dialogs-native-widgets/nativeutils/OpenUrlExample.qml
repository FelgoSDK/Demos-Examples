import Felgo


App {
  NavigationStack {
    AppPage {
      title: "Open Url"

      AppButton {
        flat: false
        text: "Open Url"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.openUrl("https://felgo.com")
        }
      }
    }
  }
}
