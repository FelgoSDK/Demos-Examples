import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "PathView"

      // Simple listmodel with colors
      ListModel {
        id: objectModel
        ListElement { itemColor: "red" }
        ListElement { itemColor: "green" }
        ListElement { itemColor: "blue" }
        ListElement { itemColor: "cyan" }
        ListElement { itemColor: "yellow" }
        ListElement { itemColor: "magenta" }
      }

      // Delegate is a simple colored rectangle
      Component {
        id: delegate
        Rectangle {
          width: dp(50)
          height: dp(50)
          color: itemColor
        }
      }

      // PathView instantiate delegates along a path we define
      PathView {
        id: pathView
        anchors.fill: parent
        model: objectModel
        delegate: delegate

        // This closed path is composed by two Bezier curves
        path: Path {
          id: path

          property real curveStartY: pathView.height / 2
          property real curveStartX: pathView.width * 0.2

          property real curveEndY: pathView.height / 2
          property real curveEndX: pathView.width * 0.8

          property real controlPointX: pathView.width / 2
          property real relativeControlPointY: pathView.height / 2

          // It's starting from the left side in the middle of the available screen
          startX: curveStartX
          startY: curveStartY

          PathQuad {
            // Bezier curves terminates at the right edge of the screen
            x: path.curveEnd
            y: path.curveEndY

            // Control is the one that defines the "bulge".
            // Here set at [0.5, 1.0], it will attract the curve towards the bottom.
            controlX: path.controlPointX
            relativeControlY: -path.relativeControlPointY
          }

          PathQuad {
            // Second bezier curve implicitly starts from the last point (middle right) and returns to the staring point
            x: path.curveStartX
            y: path.curveStartY

            // Control point is now set to the top of the screen
            controlX: path.controlPointX
            relativeControlY: path.relativeControlPointY
          }
        }
      }
    }
  }
}
