import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "NavigationBarItem"

      // Add a custom NavigationBarItem in the left slot of the NavigationBar
      leftBarItem: NavigationBarItem {
        // We specify the width of the item with the contentWidth property.
        // The item width then includes the contentWidth and a default padding
        contentWidth: contentRect.width

        // The navigation bar item shows a colored rectangle
        Rectangle {
          id: contentRect
          width: dp(Theme.navigationBar.defaultIconSize)
          height: width
          anchors.centerIn: parent
          color: Theme.navigationBar.itemColor
        }
      }
    }
  }
}

