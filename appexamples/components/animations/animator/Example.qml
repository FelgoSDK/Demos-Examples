import Felgo 3.0
// RotationAnimator and ScaleAnimator available starting QtQuick 2.2
import QtQuick 2.2


App {
  NavigationStack {
    Page {
      id: page
      title: "Animator"

      Rectangle {
        id: rectangle
        anchors.centerIn: parent
        width: dp(200)
        height: dp(200)
        color: "lightgreen"

        RotationAnimator {
          target: rectangle
          from: 0
          to: 360
          loops: Animation.Infinite
          duration: 2000
          running: true
          easing.type: Easing.InOutQuint
        }

        ScaleAnimator {
          target: rectangle
          from: 0.5
          to: 1
          duration: 2000
          running: true
          loops: Animation.Infinite
          easing.type: Easing.InOutCubic
        }
      }
    }
  }
}
