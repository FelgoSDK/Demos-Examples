import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "DropArea"

      property int dropsCount: 0

      Rectangle {
        id: content
        color: "pink"
        anchors.fill: page.contentPaddingAnchorItem
      }

      Rectangle {
        id: rectangle
        width: dp(100)
        height: dp(100)

        Component.onCompleted: {
          // Set start position of the red square at the center of the top half screen
          x = (content.width - rectangle.width) / 2
          y = (content.height - rectangle.height) / 4
        }

        // We need control our X and Y coords manually
        // since we can't use DragHandler because Drag'n'Drop there is not yet supported
        onXChanged: {
          x = Math.max(content.x, Math.min(x, content.width + content.x - rectangle.width))
        }
        onYChanged: {
          y = Math.max(content.y, Math.min(y, content.height + content.y - rectangle.height))
        }
        color: "crimson"
        opacity: Drag.active ? 0.5 : 1.0 // Change opacity based on current drag state
        z: 1
        Drag.active: dragArea.drag.active

        MouseArea {
          id: dragArea
          anchors.fill: parent
          drag.target: parent
          onReleased: {
            rectangle.Drag.drop()
          }
        }
      }

      Rectangle {
        id: dropRectangle

        anchors {
          fill: content
          topMargin: content.height / 2
        }
        color: dropArea.containsDrag ? "cornflowerblue" : "grey"

        DropArea {
          id: dropArea
          anchors.fill: parent
          onDropped: {
            page.dropsCount++
          }
        }

        AppText {
          anchors {
            margins: Theme.contentPadding
            top: parent.top
            horizontalCenter: parent.horizontalCenter
          }
          horizontalAlignment: Text.AlignHCenter
          text: "Drag and drop square here.\n" + "Drops count: " + page.dropsCount
        }
      }
    }
  }
}
