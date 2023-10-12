import Felgo 3.0
// HoverHandler is available starting QtQuick 2.12
import QtQuick 2.12


App {
  NavigationStack {
    Page {
      id: page
      title: "HoverHandler"

      Item {
        id: glassPane
        anchors.fill: parent

        Rectangle {
          parent: glassPane
          color: "red"
          x: handler.point.position.x - width / 2
          y: handler.point.position.y - height / 2
          width: dp(50)
          height: width
          radius: width / 2
        }

        HoverHandler {
          id: handler
          enabled: true
        }
      }
    }
  }
}
