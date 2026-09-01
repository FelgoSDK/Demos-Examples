import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "AnchorAnimation"

      AppText {
        id: label
        anchors {
          left: parent.left
          verticalCenter: parent.verticalCenter
        }
        text: "Re-anchor me"
      }

      AppButton {
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
          bottomMargin: nativeUtils.safeAreaInsets.bottom
        }
        text: "Re-anchor"
        flat: false
        onClicked: {
          page.state = page.state === "onLeft" ? "onRight" : "onLeft"
        }
      }

      // Note: AnchorAnimation can only be used in a Transition and in conjunction with an AnchorChange.
      // It cannot be used in behaviors and other types of animations.

      states: [
        State {
          name: "onLeft"
          AnchorChanges {
            target: label
            anchors.left: parent.left
            anchors.right: undefined
          }
        },
        State {
          name: "onRight"
          AnchorChanges {
            target: label
            anchors.left: undefined
            anchors.right: parent.right
          }
        }
      ]

      transitions: Transition {
        AnchorAnimation {
          duration: 2000
          // Re-anchor label with bounce
          easing.type: Easing.OutBounce
        }
      }
    }
  }
}
