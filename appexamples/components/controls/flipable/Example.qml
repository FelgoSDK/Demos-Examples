import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "Flipable"

      Flipable {
        id: flipable
        anchors.centerIn: parent
        width: dp(200)
        height: width

        property bool flipped: false

        front: Rectangle {
          color: "darksalmon"
          anchors.fill: parent

          AppText {
            anchors.centerIn: parent
            color: "white"
            text: "Tap me"
          }
        }

        back: Rectangle {
          anchors.fill: parent
          color: "darkturquoise"

          AppText {
            anchors.centerIn: parent
            color: "white"
            text: "Tap me again"
          }
        }

        transform: Rotation {
          id: rotation
          origin {
            x: flipable.width/2
            y: flipable.height/2
          }

          axis {
            // Set axis.y to 1 to rotate around y-axis
            x: 0; y: 1; z: 0
          }

          angle: 0
        }

        states: State {
          name: "back"
          PropertyChanges { target: rotation; angle: 180 }
          when: flipable.flipped
        }

        transitions: Transition {
          NumberAnimation { target: rotation; property: "angle"; duration: 2000 }
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            flipable.flipped = !flipable.flipped
          }
        }
      }
    }
  }
}
