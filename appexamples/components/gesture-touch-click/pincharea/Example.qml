import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "PinchArea"

      PinchArea {
        id: pinchArea
        anchors.fill: parent
        pinch {
          target: circle
          minimumScale: 0.5
          maximumScale: 2.0
          minimumRotation: -180
          maximumRotation: 180
        }
      }

      Rectangle {
        id: circle
        x: (parent.width - circle.width) / 2
        y: (parent.height- circle.height) / 2
        width: dp(200)
        height: width
        border {
          color: "darkolivegreen"
          width: 5
        }
        opacity: pinchArea.pinch.active ? 0.8 : 1.0

        gradient: Gradient {
          GradientStop { position: 0.0; color: "blueviolet" }
          GradientStop { position: 1.0; color: "darkseagreen" }
        }

        AppText {
          anchors.centerIn: parent
          horizontalAlignment: Text.AlignHCenter
          text: "Scale: " + circle.scale.toFixed(2)
                + "\n Rotation: " + circle.rotation.toFixed(2)
        }
      }
    }
  }
}
