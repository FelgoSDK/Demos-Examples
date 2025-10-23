import QtQuick.Controls
import QtQuick
import Felgo

App {
  NavigationStack {
    AppPage {
      id: page
      title: "RoundedImage"

      RoundedImage {
        id: roundedImage
        width: dp(200)
        height: width
        anchors.centerIn: parent
        source: Qt.resolvedUrl("assets/400x400.jpg")
        radius: width / 2

        // Display a small grey border around the image
        border.width: dp(2)
        border.color: "lightgrey"

        // Display an indicator while the image is loading
        AppActivityIndicator {
          anchors.centerIn: parent
          visible: roundedImage.img.status === AppImage.Loading
        }
      }
    }
  }
}
