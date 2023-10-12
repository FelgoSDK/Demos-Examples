import Felgo 3.0
import QtQuick 2.0
import QtSensors 5.0

App {
  readonly property double radians_to_degrees: 180 / Math.PI

  function calcPitch(x,y,z) {
    return -Math.atan2(y, Math.hypot(x, z)) * radians_to_degrees;
  }

  function calcRoll(x,y,z) {
    return -Math.atan2(x, Math.hypot(y, z)) * radians_to_degrees;
  }

  NavigationStack {
    Page {
      id: page
      preferredScreenOrientation: NativeUtils.ScreenOrientationPortrait
      title: "Accelerometer"

      Accelerometer {
        id: accel
        dataRate: 100
        active:true
        onReadingChanged: {
          // Calculate new ball position based on newly read data from accelerometer
          var newX = (bubble.x + calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1)
          var newY = (bubble.y - calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1)

          if (isNaN(newX) || isNaN(newY)) {
            return
          }
          if (newX < 0) {
            newX = 0
          }
          if (newX > page.safeArea.width - bubble.width) {
            newX = page.safeArea.width - bubble.width
          }
          if (newY < 1) {
            newY = 0
          }
          if (newY > page.safeArea.height - bubble.height) {
            newY = page.safeArea.height - bubble.height
          }
          bubble.x = newX
          bubble.y = newY
        }
      }

      Icon {
        id: bubble
        icon: IconType.soccerballo
        smooth: true
        property real centerX: 100
        property real centerY: 100
        property real bubbleCenter: bubble.width / 2
        x: centerX - bubbleCenter
        y: centerY - bubbleCenter

        Behavior on y {
          SmoothedAnimation {
            easing.type: Easing.Linear
            duration: 100
          }
        }

        Behavior on x {
          SmoothedAnimation {
            easing.type: Easing.Linear
            duration: 100
          }
        }
      }
    }
  }
}
