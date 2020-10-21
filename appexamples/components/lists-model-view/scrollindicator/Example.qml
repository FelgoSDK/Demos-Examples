import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "ScrollIndicator"

      AppFlickable {
        id: appFlickable
        anchors.fill: parent
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

      ScrollIndicator {
        flickable: appFlickable
      }
    }
  }
}

