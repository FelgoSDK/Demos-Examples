import Felgo 4.0
import QtQuick 2.12
import QtPositioning 5.12
import QtLocation 5.12 as QL
import "../"


AppPage {
  id: root
  title: qsTr("User position")

  AppMap {
    id: appMap
    anchors.fill: parent
    showUserPosition: true
    enableUserPosition: true

    // Configure map provider
    plugin: MapPlugin {}

    QL.MapQuickItem {
      id: userPositionMarker

      anchorPoint {
        x: sourceItem.width / 2
        y: sourceItem.height / 2
      }

      visible: true

      sourceItem: AppIcon {
        iconType: IconType.mapmarker
        color: "red"
        size: dp(30)
      }
    }

    Component.onCompleted: {
      showUserPosition()
    }

    onUserPositionAvailableChanged: {
      showUserPosition()
    }

    function showUserPosition() {
      if (userPositionAvailable) {
        center = userPosition.coordinate
        zoomLevel = 13
      }
    }
  }

  AppPaper {
    height: label.height
    anchors {
      bottom: parent.bottom
      bottomMargin: dp(10)
      left: parent.left
      right: parent.right
      margins: dp(10)
    }
    visible: !appMap.userPositionAvailable

    AppText {
      id: label

      width: parent.width

      horizontalAlignment: Text.AlignHCenter
      padding: 15
      text: qsTr("User position is not available")
    }
  }
}
