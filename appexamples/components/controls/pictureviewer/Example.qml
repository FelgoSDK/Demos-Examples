import Felgo 3.0


App {
  id: app

  NavigationStack {
    Page {
      id: page
      title: "PictureViewer"

      AppButton {
        text: "Show image"
        anchors.centerIn: parent
        onClicked: {
          // Open PictureViewer component. Replace with the URI of your image
          PictureViewer.show(app, "assets/felgo-logo.png")
        }
      }
    }
  }
}
