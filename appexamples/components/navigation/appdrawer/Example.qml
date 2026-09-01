import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "AppDrawer"

      AppDrawer {
        // All items inside AppDrawer will be placed in the drawer area
        id: drawer

        // Put drawer on top of other content
        z: 1

        // Drawer background
        Rectangle {
          anchors.fill: parent
          color: "white"
        }

        AppButton {
          anchors.centerIn: parent
          text: "Test"
          onClicked: {
            testTxt.text = "Button in drawer clicked"
            drawer.close()
          }
        }
      }

      Column {
        anchors.centerIn: parent
        spacing: dp(16)

        AppText {
          id: testTxt
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Swipe from left to open drawer"
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Open drawer manually"
          onClicked: {
            drawer.open()
          }
        }
      }
    }
  }
}

