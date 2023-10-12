import Felgo 3.0
import QtQuick 2.0


App {

  // helper method to get random value from given interval
  function getRandomArbitrary(min, max) {
    return Math.random() * (max - min) + min;
  }

  function randomizeLabelPosition() {
    label.x = getRandomArbitrary(0, page.width - label.width)
    label.y = getRandomArbitrary(0, page.height * 0.9 - label.height)
  }

  NavigationStack {
    Page {
      id: page
      title: "PropertyAnimation"

      AppText {
        id: label
        x: 0
        y: 0
        text: "Let's play"

        Behavior on x {
          PropertyAnimation {
            easing.type: Easing.OutInCirc
          }
        }

        Behavior on y {
          PropertyAnimation {
            easing.type: Easing.InOutBack
          }
        }
      }

      AppButton {
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.safeArea.bottom
        }
        flat: false
        text: "Randomize Label Position"
        onClicked: {
          randomizeLabelPosition()
        }
      }
    }
  }
}
