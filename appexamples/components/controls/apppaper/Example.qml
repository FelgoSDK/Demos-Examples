import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "AppPaper"

      AppPaper {
        anchors.centerIn: parent
        width: dp(300)
        height: appText.height
        // Elevate the card if it is pressed
        elevated: mouseArea.pressed
        radius: dp(20)

        AppText {
          id: appText
          width: parent.width
          padding: dp(16)
          text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore "
                + "et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
                + "aliquip ex ea commodo consequat."
        }

        MouseArea {
          id: mouseArea
          anchors.fill: parent
        }
      }
    }
  }
}
