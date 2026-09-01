import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "Behavior"

      // Centered text which fades when opacity changes
      AppText {
        id: textItem
        anchors.centerIn: parent
        text: "Hello World!"
        font {
          bold: true
          pixelSize: sp(30)
        }
        visible: opacity != 0 // Also set invisible when fully transparent

        // When opacity changes ...
        Behavior on opacity {
          NumberAnimation { duration: 500 } // ... animate to reach new value within 500ms
        }
      }

      AppButton {
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
          bottomMargin: nativeUtils.safeAreaInsets.bottom
        }
        text: "Toggle Text Item"
        onClicked: {
          // Toggle textItem visibility
          textItem.opacity = textItem.visible ? 0 : 1
        }
      }
    }
  }
}
