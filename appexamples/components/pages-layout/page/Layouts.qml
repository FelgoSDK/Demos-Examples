import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {

    AppPage {
      title: "Anchoring"

      AppText {
        id: centerItem
        anchors.centerIn: parent
        text: "Centered"
      }

      AppText {
        anchors {
          top: parent.top
          left: parent.left
        }
        text: "TopLeft"
      }

      AppText {
        anchors {
          top: parent.top
          right: parent.right
        }
        text: "TopRight"
      }

      AppText {
        anchors {
          bottom: parent.bottom
          left: parent.left
        }
        text: "BottomLeft"
      }

      AppText {
        anchors {
          bottom: parent.bottom
          right: parent.right
        }
        text: "BottomRight"
      }

      // This item uses some more available anchoring options centerItem is a sibling of this text, thus we can anchor to it
      AppText {
        anchors {
          verticalCenter: centerItem.verticalCenter // Anchoring by vertical center
          verticalCenterOffset: dp(10)              // Positive or negative offset from the vertical center
          right: centerItem.left                    // We anchor the right edge to the left edge of centerItem
          rightMargin: dp(20)                       // This creates an offset from the right edge
        }
        text: "Relative"
      }
    }
  }
}
