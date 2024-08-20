import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "IconButton"

      Column {
        anchors.centerIn: parent
        spacing: dp(20)

        IconButton {
          anchors.horizontalCenter: parent.horizontalCenter
          // Icon in default state
          iconType: IconType.hearto

          // Icon in selected state
          selectedIconType: IconType.heart

          toggle: true

          onToggled: {
            console.log("Heart IconButton toggled " + toggle)
          }
        }

        IconButton {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.angledoubledown
          selectedIconType: IconType.angledoubleup
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
