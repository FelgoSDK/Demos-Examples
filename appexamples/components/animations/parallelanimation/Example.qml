import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "ParallelAnimation"

      AppButton {
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
        }
        text: "Move!"
        flat: false
        onClicked: {
          if (rectangle.x === 0) {
            animationDown.start()
          } else {
            animationUp.start()
          }
        }
      }

      Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: dp(100)
        height: dp(100)
        color: "lightgreen"
      }

      ParallelAnimation {
        id: animationDown
        NumberAnimation {
          target: rectangle
          property: "x"
          from: 0
          to: page.width - rectangle.width
          duration: 1000
          easing.type: Easing.OutQuad
        }
        NumberAnimation {
          target: rectangle
          property: "y"
          from: 0
          to: page.height * 0.9 - rectangle.height
          duration: 1000
          easing.type: Easing.InQuad
        }
      }

      ParallelAnimation {
        id: animationUp
        NumberAnimation {
          target: rectangle
          property: "x"
          from: page.width - rectangle.width
          to: 0
          duration: 1000
          easing.type: Easing.InOutBack
        }
        NumberAnimation {
          target: rectangle
          property: "y"
          from: page.height * 0.9 - rectangle.height
          to: 0
          duration: 1000
          easing.type: Easing.InBack
        }
      }
    }
  }
}
