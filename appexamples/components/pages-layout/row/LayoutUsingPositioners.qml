import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {

    Page {
      title: "Layout using Positioners"

      // Aligns all child items in a row
      Row {
        anchors.centerIn: parent

        // This is the space between each item in the row
        spacing: dp(10)

        Rectangle {
          width: dp(100)
          height: dp(100)
          color: "red"
        }

        Rectangle {
          width: dp(100)
          height: dp(100)
          color: "green"
        }

        Rectangle {
          width: dp(100)
          height: dp(100)
          color: "blue"
        }
      }
    }
  }
}
