import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {

    AppPage {
      id: page
      title: "Custom Title Item"

      // Define a custom titleItem, that consists of an image and a title text
      titleItem: Row {
        spacing: dp(6)

        Image {
          anchors.verticalCenter: parent.verticalCenter
          height: titleText.height
          fillMode: Image.PreserveAspectFit
          source: "assets/felgo-logo.png"
        }

        AppText {
          id: titleText
          anchors.verticalCenter: parent.verticalCenter
          text: page.title
          font {
            bold: true
            family: Theme.boldFont.name
            pixelSize: dp(Theme.navigationBar.titleTextSize)
          }
          color: "maroon"
        }
      }
    }
  }
}
