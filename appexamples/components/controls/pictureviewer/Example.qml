import Felgo 4.0


App {
  id: app

  NavigationStack {
    AppPage {
      id: page
      title: "PictureViewer"

      AppButton {
        text: "Show image"
        anchors.centerIn: parent
        onClicked: {
          // Open PictureViewer component. Replace with the URI of your image
          PictureViewer.show(app, Qt.resolvedUrl("assets/felgo-logo.png"))
        }
      }
    }
  }
}
