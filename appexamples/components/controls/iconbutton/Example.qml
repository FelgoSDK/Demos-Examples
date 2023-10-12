import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "IconButton"

      Column {
        anchors.centerIn: parent
        spacing: dp(20)

        IconButton {
          anchors.horizontalCenter: parent.horizontalCenter
          // Icon in default state
          icon: IconType.hearto

          // Icon in selected state
          selectedIcon: IconType.heart

          toggle: true

          onToggled: {
            console.log("Heart IconButton toggled " + toggle)
          }
        }

        IconButton {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.angledoubledown
          selectedIcon: IconType.angledoubleup
          color: "goldenrod"
          selectedColor: "gold"

          toggle: true

          onToggled: {
            console.log("Arrow IconButton toggled " + toggle)
          }
        }
      }
    }
  }
}
