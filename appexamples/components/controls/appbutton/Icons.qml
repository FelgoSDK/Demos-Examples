import QtQuick 2.8
import Felgo 3.0

App {
  NavigationStack {
    Page {
      title: "AppButton"

      Column {
        width: parent.width

        AppButton {
          text: "Icon"
          icon: IconType.heart
        }

        AppButton {
          text: "Left Icon"
          iconLeft: IconType.heart
        }

        AppButton {
          text: "Right Icon"
          iconRight: IconType.heart
        }

        AppButton {
          id: customButton
          text: "Custom left item"
          leftItem: Rectangle {
            width: dp(15)
            height: width
            rotation: 45
            color: "green"
            // Handling the pressed state on iOS in the custom item
            opacity: Theme.isIos && customButton.pressed ? 0.5 : 1
          }
        }

        AppButton {
          text: "Full width"
          width: parent.width
          iconRight: IconType.heart
        }

        AppButton {
          text: "Circle"
          icon: IconType.heart
          height: width
          radius: width/2
        }
      }
    }
  }
}
