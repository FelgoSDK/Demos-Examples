import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    FlickablePage {
      title: "Flickable Page"

      // Set contentHeight of flickable to allow scrolling
      flickable.contentHeight: column.height

      // Set false to hide the scroll indicator, it is visible by default
      scrollIndicator.visible: true

      // page content
      Column {
        id: column
        width: parent.width

        // Fill column with 100 AppText items using Repeater
        Repeater {
          model: 100
          delegate: Rectangle {
            width: parent.width
            height: dp(50)
            AppText {
              anchors.centerIn: parent
              text: qsTr("Item") + " " + index
            }
          }
        }
      }
    }
  }
}
