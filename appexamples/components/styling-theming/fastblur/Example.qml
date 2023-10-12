import Felgo 3.0
import QtQuick 2.5
import QtGraphicalEffects 1.0


App {
  NavigationStack {

    ListPage {
      id: page
      title: "Blur Effect"

      // Get the total height of status bar and navigation bar
      readonly property real barHeight: dp(Theme.navigationBar.height) + Theme.statusBarHeight

      // Navigation bar is 100 percent translucent, the page then also fills the whole screen,
      // this allows us to display a custom navigation bar background for this page
      navigationBarTranslucency: 1.0

      // List view only fills page area below navigation bar
      listView.anchors.topMargin: barHeight

      model: 20 // twenty dummy items
      delegate: SimpleRow { text: "Item #" + index }

      // Custom navigation bar background that shows an image
      Rectangle {
        id: background
        width: parent.width
        height: page.barHeight
        color: Theme.navigationBar.backgroundColor

        // Add the image
        Image {
          id: bgImage
          source: "../assets/felgo-logo.png"
          anchors.fill: parent
          fillMode: Image.PreserveAspectCrop

          // Blur effect displays the image, we set the source image invisible
          visible: false
        }

        // Apply blur effect
        FastBlur {
          id: blur
          source: bgImage
          anchors.fill: bgImage

          // "strength" of the blur is based on the list view scroll position
          radius: Math.max(0, Math.min(64, page.listView.contentY))
        }
      }
    }
  }
}
