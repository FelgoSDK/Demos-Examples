import Felgo
import QtQuick
import QtPositioning
import QtLocation as QL
import "../"


AppPage {
  id: root
  title: qsTr("Reverse geocoding")

  AppMap {
    id: appMap

    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    // Configure map provider
    plugin: MapPlugin {}

    MouseArea {
      id: appMapMA

      anchors.fill: parent

      onPressAndHold: mouse => {
        marker.visible = false
        var coordinates = appMap.toCoordinate(Qt.point(mouse.x, mouse.y))
        geocodeModel.query = coordinates
        marker.coordinate = coordinates
      }
    }

    QL.MapQuickItem {
      id: marker
      visible: false
      anchorPoint {
        x: sourceItem.width / 2
        y: sourceItem.height
      }

      sourceItem: AppIcon {
        iconType: IconType.mapmarker
        color: "red"
        size: dp(30)
      }
    }
  }

  QL.GeocodeModel {
    id: geocodeModel
    plugin: MapPlugin {
      geocoding: true
    }
    autoUpdate: true

    onLocationsChanged: {
      if (count > 0) {
        marker.visible = true
        var address = get(0).address
        label.text = address.street + " " + address.city + " " + address.country
      }
    }
  }

  AppPaper {
    height: label.height
    anchors {
      bottom: parent.safeArea.bottom
      left: parent.left
      right: parent.right
      margins: dp(10)
    }

    AppText {
      id: label

      width: parent.width

      horizontalAlignment: Text.AlignHCenter
      padding: 15
      text: qsTr("Hold anywhere on the map to display address")
    }
  }

  AppActivityIndicator {
    id: busyIndicator
    anchors.centerIn: parent
    visible: geocodeModel.status === QL.GeocodeModel.Loading
  }
}
