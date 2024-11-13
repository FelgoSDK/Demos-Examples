import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "Flickable"

      Row {
        anchors {
          top: page.contentPaddingAnchorItem.top
          left: page.contentPaddingAnchorItem.left
          right: page.contentPaddingAnchorItem.right
        }
        spacing: dp(10)

        AppText {
          font.bold: true
          text: "Flickable status:"
        }

        AppText {
          id: status
          text: {
            if (flickable.dragging) {
              return "Dragging..."
            } else if (flickable.flicking) {
              return "Flicking..."
            } else if (flickable.moving) {
              return "Moving..."
            }
            return "Ready!"
          }
        }
      }

      Flickable {
        id: flickable
        anchors {
          topMargin: dp(30)
          fill: page.contentPaddingAnchorItem
        }
        clip: true

        contentWidth: content.width
        contentHeight: content.height

        rebound: Transition {
          NumberAnimation {
            properties: "x,y"
            easing.type: Easing.OutExpo
          }
        }

        Rectangle {
          id: content
          width: dp(1000)
          height: dp(1000)
          gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "blue" }
          }

          AppText {
            anchors {
              top: parent.top
              left: parent.left
              margins: Theme.contentPadding
            }
            font.bold: true
            style: Text.Outline
            styleColor: "white"
            text: "Top left corner"
          }

          AppText {
            anchors {
              bottom: parent.bottom
              right: parent.right
              margins: Theme.contentPadding
            }
            font.bold: true
            style: Text.Outline
            styleColor: "white"
            text: "Bottom right corner"
          }
        }
      }
    }
  }
}
