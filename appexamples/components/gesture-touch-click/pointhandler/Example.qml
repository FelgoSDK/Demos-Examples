import Felgo 3.0
// PointHandler is available starting QtQuick 2.12
import QtQuick 2.12


App {
  NavigationStack {
    Page {
      id: page
      title: "PointHandler"

      Item {
        id: glassPane
        anchors.fill: parent

        PointHandler {
          id: handler
          target: Rectangle {
            parent: glassPane
            color: "crimson"
            visible: handler.active
            x: handler.point.position.x - width / 2
            y: handler.point.position.y - height / 2
            width: dp(50)
            height: width
            radius: width / 2
          }
        }
      }
    }
  }
}
