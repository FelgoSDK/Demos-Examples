import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {

    Page {
      id: page
      title: "My Title"

      // We define a custom titleItem, that consists of an image and a title text
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
          font.bold: true
          font.family: Theme.boldFont.name
          font.pixelSize: dp(Theme.navigationBar.titleTextSize)
          color: "orange"
        }
      }
    }
  }
}
