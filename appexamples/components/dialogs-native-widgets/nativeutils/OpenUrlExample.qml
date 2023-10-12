import Felgo 3.0


App {
  NavigationStack {
    Page {
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
