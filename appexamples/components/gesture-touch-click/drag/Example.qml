import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "Drag"

      property bool hasReachedBottom: false

      Rectangle {
        anchors.fill: dropArea
        color: "green"
        visible: page.hasReachedBottom
      }

      DropArea {
        id: dropArea
        height: parent.height / 2
        anchors {
          left: parent.left
          right: parent.right
          bottom: parent.bottom
        }

        // Contains drag is fired when a draggable item is within its bounds
        onContainsDragChanged: {
          if (containsDrag) {
            page.hasReachedBottom = true
          }
        }
      }

      AppText {
        id: dropText
        anchors.centerIn: dropArea
        text: page.hasReachedBottom ? "Thanks" : "Move something in here"
      }

      Rectangle {
        // Let's position the red square at the center of the top half screen.
        x: (parent.width - width) / 2
        y: (parent.height - height) / 4

        width: dp(100)
        height: dp(100)

        color: "red"
        z: 1

        Drag.active: dragArea.drag.active

        MouseArea {
          id: dragArea
          anchors.fill: parent
          drag.target: parent
        }
      }
    }
  }
}
