import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "App"

      AppText {
        anchors {
          top: parent.top
          left: parent.left
          margins: dp(30)
        }

        text: "Here are useful available App properties:"
              + "\n diameterInInches " + diameterInInches.toFixed(2)
              + "\n heightInInches " + heightInInches.toFixed(2)
              + "\n screenHeight " + screenHeight.toFixed(2)
              + "\n screenWidth " + screenWidth.toFixed(2)
              + "\n isOnline " + isOnline
              + "\n landscape " + landscape
              + "\n portrait " + portrait
      }
    }
  }
}
