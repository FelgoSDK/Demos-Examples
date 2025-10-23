import Felgo
import QtQuick

App {
  NavigationStack {
    AppPage {
      title: "Dynamic Overlay"

      AppButton {
        text: "Open Overlay"
        anchors.centerIn: parent
        onClicked: myOverlay.open()
      }

      AppOverlay {
        id: myOverlay
        sourceItem: overlayComponent
        onOpening: item.closeClicked.connect(myOverlay.close)
      }

      Component {
        id: overlayComponent
        Rectangle {
          id: item
          anchors.centerIn: parent
          color: Theme.backgroundColor
          width: dp(250)
          height: dp(130)

          signal closeClicked

          AppText {
            text: "Dynamic Overlay"
            y: dp(36)
            anchors.horizontalCenter: parent.horizontalCenter
          }

          AppButton {
            text: "Close"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            flat: true
            onClicked: item.closeClicked()
          }
        }
      }
    }
  }
}
