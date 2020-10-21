import Felgo 3.0
// TapHandler is available starting QtQuick 2.12
import QtQuick 2.12


App {
  NavigationStack {
    Page {
      id: page
      title: "TapHandler"

      Rectangle {
        anchors.centerIn: parent
        width: dp(200)
        height: dp(200)
        color: "darkorange"

        AppText {
          anchors {
            margins: Theme.contentPadding
            bottom: parent.bottom
            right: parent.right
          }
          horizontalAlignment: Text.AlignRight
          text: "Taps count: " + tapHandler.tapCount + "\n"
                + "Double taps count: " + tapHandler.doubleTapCount + "\n"
                + "Long press count: " + tapHandler.longPressCount
        }

        TapHandler {
          id: tapHandler
          property int tapCount: 0
          property int doubleTapCount: 0
          property int longPressCount: 0
          onTapped: {
            tapCount++
          }
          onDoubleTapped: {
            doubleTapCount++
          }
          onLongPressed: {
            longPressCount++
          }
        }
      }
    }
  }
}
