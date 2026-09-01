import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "AppFlickable"

      AppFlickable {
        anchors.fill: parent

        // Setting contentHeight lets the flickable know how much it will have to allow scrolling.
        contentHeight: content.height

        Column {
          id: content
          width: parent.width

          Repeater {
            model: 50
            AppText {
              width: content.width
              height: dp(50)
              text: "Text Item #" + index
              horizontalAlignment: Text.AlignHCenter
            }
          }
        }
      }
    }
  }
}
