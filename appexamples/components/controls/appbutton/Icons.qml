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
          flat: false
          icon: IconType.heart
        }

        AppButton {
          text: "Left Icon"
          flat: false
          iconLeft: IconType.heart
        }

        AppButton {
          text: "Right Icon"
          flat: false
          iconRight: IconType.heart
        }

        AppButton {
          id: customButton
          text: "Custom left item"
          flat: false
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
          flat: false
          width: parent.width
          iconRight: IconType.heart
        }

        AppButton {
          text: "Circle"
          flat: false
          icon: IconType.heart
          
          // Create circle with width=height and radius
          width: dp(70)
          height: width
          radius: width/2

          // Reset default values to not interfere with circle shape
          minimumWidth: 0
          minimumHeight: 0
          horizontalPadding: 0
          verticalPadding: 0
          horizontalMargin: 0
          verticalMargin: 0
        }
      }
    }
  }
}
