import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "PinchEvent"

      PinchArea {
        id: pinchArea
        anchors.fill: parent
        pinch {
          target: circle
          minimumScale: 0.5
          maximumScale: 2.0
        }

        onPinchStarted: {
          // pinch argument here is PinchEvent, not PinchArea.pinch
          startPoint1.x = pinch.startPoint1.x
          startPoint1.y = pinch.startPoint1.y
          startPoint2.x = pinch.startPoint2.x
          startPoint2.y = pinch.startPoint2.y
        }

        onPinchUpdated: {
          // pinch argument here is PinchEvent, not PinchArea.pinch
          currentPoint1.x = pinch.point1.x
          currentPoint1.y = pinch.point1.y
          currentPoint2.x = pinch.point2.x
          currentPoint2.y = pinch.point2.y
        }
      }

      Rectangle {
        id: circle
        x: (parent.width - circle.width) / 2
        y: (parent.height - circle.height) / 2
        width: dp(200)
        height: width
        border {
          color: "darkolivegreen"
          width: 5
        }
        radius: width / 2
        opacity: pinchArea.pinch.active ? 0.8 : 1.0
        color: "darksalmon"
      }

      Rectangle {
        id: startPoint1
        width: dp(50)
        height: width
        radius: width / 2
        color: "violet"
        visible: pinchArea.pinch.active
      }

      Rectangle {
        id: startPoint2
        width: dp(50)
        height: width
        radius: width / 2
        color: "darkorange"
        visible: pinchArea.pinch.active
      }

      Rectangle {
        id: currentPoint1
        width: dp(50)
        height: width
        radius: width / 2
        color: Qt.darker(startPoint1.color)
        opacity: 0.7
        visible: pinchArea.pinch.active
      }

      Rectangle {
        id: currentPoint2
        width: dp(50)
        height: width
        radius: width / 2
        color: Qt.darker(startPoint2.color)
        opacity: 0.7
        visible: pinchArea.pinch.active
      }
    }
  }
}
