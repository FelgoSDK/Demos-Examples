import Felgo
import QtQuick


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
    AppPage {
      id: page
      title: "NumberAnimation"

      AppText {
        id: label
        x: 0
        y: 0
        text: "Let's play"

        Behavior on x {
          NumberAnimation { }
          // NOTE: SpringAnimation is special case of NumberAnimation for spring-like motion
          // SpringAnimation { spring: 2; damping: 0.1 }
        }

        Behavior on y {
          NumberAnimation { }
          // SpringAnimation { spring: 2; damping: 0.1 }
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
