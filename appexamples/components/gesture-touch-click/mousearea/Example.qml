import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "MouseArea"

      Rectangle {
        anchors.centerIn: parent
        width: dp(200)
        height: dp(200)
        color: "darkorange"

        border {
          color: "lightgrey"
          // Show border if MouseArea contains mouse
          width: mouseArea.containsMouse ? dp(5) : 0
        }

        AppText {
          anchors {
            margins: Theme.contentPadding
            bottom: parent.bottom
            right: parent.right
          }
          horizontalAlignment: Text.AlignRight
          text: "Clicks count: " + mouseArea.clicksCount + "\n"
                + "Long press count: " + mouseArea.longPressCount
        }

        MouseArea {
          id: mouseArea
          property int clicksCount: 0
          property int longPressCount: 0

          anchors.fill: parent
          hoverEnabled: true
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onPressAndHold: {
            longPressCount++
          }

          onClicked: {
            clicksCount++
            // Change color of rectangle depending on mouse button clicked
            if (mouse.button === Qt.RightButton) {
              parent.color = 'darkorange'
            } else {
              parent.color = 'darkolivegreen'
            }
          }
        }
      }
    }
  }
}
