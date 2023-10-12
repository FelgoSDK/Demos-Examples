import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "SequentialAnimation"

      AppButton {
        anchors.centerIn: parent
        text: "Move!"
        flat: false
        onClicked: {
          // Start the animation by calling start() of the top-most item
          complexAnimation.start()
        }
      }

      Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: dp(100)
        height: dp(100)
        color: "lightgreen"
      }

      // All child animations will be executed one after the other
      SequentialAnimation {
        // You can start the whole animation by calling start() of the top-most item
        id: complexAnimation

        // 1. Move to right
        NumberAnimation {
          target: rectangle
          property: "x"
          to: page.width - rectangle.width
          duration: 1000
        }

        // 2. Move down and change color
        // All child animations will be executed in parallel
        ParallelAnimation {
          NumberAnimation {
            target: rectangle
            property: "y"
            to: page.height - 2 * rectangle.height
            duration: 1000
            easing.type: Easing.InOutQuad
          }
          ColorAnimation {
            target: rectangle
            property: "color"
            to: "hotpink"
            duration: 1000
          }
        }

        // 3. Move left, change color and rotate
        // All child animations will be executed in parallel
        ParallelAnimation {
          NumberAnimation {
            target: rectangle
            property: "x"
            to: 0
            duration: 1000
          }
          ColorAnimation {
            target: rectangle
            property: "color"
            to: "lavender"
            duration: 1000
          }
          NumberAnimation {
            target: rectangle
            property: "rotation"
            from: 0
            to: 360
            duration: 1000
          }
        }

        // 4. Move up
        NumberAnimation {
          target: rectangle
          property: "y"
          to: 0
          duration: 1000
          easing.type: Easing.InBack
        }
      }
    }
  }
}
