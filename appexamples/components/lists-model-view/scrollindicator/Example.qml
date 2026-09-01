import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "AppScrollIndicator"

      AppFlickable {
        id: appFlickable
        anchors.fill: parent
        contentHeight: content.height
        bottomMargin: nativeUtils.safeAreaInsets.bottom

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

      AppScrollIndicator {
        flickable: appFlickable
      }
    }
  }
}

