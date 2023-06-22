import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "MultiPointTouchArea"

      MultiPointTouchArea {
        anchors.fill: parent
        maximumTouchPoints: 2
        touchPoints: [
          TouchPoint { id: point1 },
          TouchPoint { id: point2 }
        ]
      }

      Rectangle {
        width: dp(50)
        height: width
        radius: width / 2
        color: "aquamarine"
        x: point1.x
        y: point1.y
        Behavior on x { PropertyAnimation { duration: 100 } }
        Behavior on y { PropertyAnimation { duration: 100 } }
      }

      Rectangle {
        width: dp(50)
        height: width
        radius: width / 2
        color: "cadetblue"
        x: point2.x
        y: point2.y
        Behavior on x { PropertyAnimation { duration: 100 } }
        Behavior on y { PropertyAnimation { duration: 100 } }
      }
    }
  }
}
