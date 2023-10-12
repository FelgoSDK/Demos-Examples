import Felgo 3.0
import QtQuick 2.0


App {
  Navigation {
    navigationMode: navigationModeDrawer

    NavigationItem {
      title: "Spinner"
      NavigationStack {
        Page {
          title: "Spinner"

          AppText {
            id: spinnerLabel
            anchors.centerIn: parent
            text: "Weeeeeeeee"
          }

          NumberAnimation {
            running: true             // Start automatically
            loops: Animation.Infinite // Repeat endless (unless stopped)
            target: spinnerLabel      // The animated item id
            property: "rotation"      // The animated property
            from: 0                   // Start value. If not defined, the current value is used
            to: 360                   // End value
            duration: 1000            // Duration of the animation
          }
        }
      }
    }

    NavigationItem {
      title: "Triggered Animation"
      NavigationStack {
        Page {
          title: "Triggered Animation"

          AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Spin"
            flat: false
            // The button is disabled while the animation is running
            enabled: !triggeredAnimation.running
            onClicked: {
              triggeredAnimation.start()
            }
          }

          AppText {
            id: triggeredAnimationLabel
            anchors.centerIn: parent
            // The text changes while the animation is running
            text: triggeredAnimation.running ? "Weeeeeeeee" : "Spin me!"
          }

          NumberAnimation {
            id: triggeredAnimation
            target: triggeredAnimationLabel
            property: "rotation"
            from: 0
            to: 360
            duration: 2000
          }
        }
      }
    }

    NavigationItem {
      title: "Animation with Easing"
      NavigationStack {
        Page {
          title: "Animation with Easing"

          AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Spin"
            flat: false
            enabled: !easingAnimation.running
            onClicked: {
              easingAnimation.start()
            }
          }

          AppText {
            id: easingAnimationLabel
            anchors.centerIn: parent
            text: easingAnimation.running ? "Weeeeeeeee" : "Spin me!"
          }

          NumberAnimation {
            id: easingAnimation
            target: easingAnimationLabel
            property: "rotation"
            from: 0
            to: 360
            duration: 2000
            easing.type: Easing.InOutBack
          }
        }
      }
    }

    NavigationItem {
      title: "Color Animation"
      NavigationStack {
        Page {
          title: "Color Animation"

          AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Colorize"
            flat: false
            onClicked: {
              // Set random color as destination color and start animation
              colorAnimation.to = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
              colorAnimation.start()
            }
          }

          Rectangle {
            id: colorRectangle
            anchors.centerIn: parent
            width: dp(200)
            height: dp(200)
            color: "#ff0000" // Beautiful red color
          }

          ColorAnimation {
            id: colorAnimation
            target: colorRectangle
            property: "color"
            duration: 1000
          }
        }
      }
    }

    NavigationItem {
      title: "Complex Animation"
      NavigationStack {
        Page {
          title: "Complex Animation"

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
            width: dp(100)
            height: dp(100)
            color: "black"
          }

          // All child animations will be executed one after the other
          SequentialAnimation {
            // You can start the whole animation by calling start() of the top-most item
            id: complexAnimation

            // 1. Move to right
            NumberAnimation {
              target: rectangle
              property: "x"
              to: parent.width - rectangle.width
              duration: 1000
            }

            // 2. Move down and change color
            // All child animations will be executed in parallel
            ParallelAnimation {
              NumberAnimation {
                target: rectangle
                property: "y"
                to: parent.height - 2 * rectangle.height
                duration: 1000
                easing.type: Easing.InOutQuad
              }
              ColorAnimation {
                target: rectangle
                property: "color"
                to: "blue"
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
                to: "black"
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

    NavigationItem {
      title: "Action after Animation Stops"
      NavigationStack {
        Page {
          title: "Action after Animation Stops"

          Column {
            anchors.centerIn: parent
            AppButton {
              anchors.horizontalCenter: parent.horizontalCenter
              text: "Animation"
              flat: false
              enabled: !animation.running
              onClicked: {
                animationLog.text += "\nAnimation started"
                animation.start()
              }
            }
            AppButton {
              anchors.horizontalCenter: parent.horizontalCenter
              text: "SequentialAnimation"
              flat: false
              enabled: !sequentialAnimation.running
              onClicked: {
                animationLog.text += "\nSequentialAnimation started"
                sequentialAnimation.start()
              }
            }
          }

          AppText {
            id: animationLog
          }

          // Animations don't actually animate anything in this example, but still they will run
          NumberAnimation {
            id: animation
            duration: 1000
            onStopped: {
              animationLog.text += "\nAnimation stopped"
            }
          }

          SequentialAnimation {
            id: sequentialAnimation
            NumberAnimation {
              duration: 1000
            }
            ScriptAction {
              script: {
                animationLog.text += "\nSequentialAnimation stopped"
              }
            }
          }
        }
      }
    }

    NavigationItem {
      title: "Animate Item properties automatically"
      NavigationStack {
        Page {
          title: "Animate Item properties automatically"

          // Button at the bottom allows to toggle the text
          AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Toggle Text Item"
            onClicked: {
              textItem.opacity = textItem.visible ? 0 : 1 // Toggle textItem visibility
            }
          }

          // Centered text which fades when opacity changes
          AppText {
            id: textItem
            anchors.centerIn: parent
            text: "Hello World!"
            visible: opacity != 0 // Also set invisible when fully transparent

            // When opacity changes ...
            Behavior on opacity {
              NumberAnimation { duration: 500 } // ... animate to reach new value within 500ms
            }
          }
        }
      }
    }
  }
}
