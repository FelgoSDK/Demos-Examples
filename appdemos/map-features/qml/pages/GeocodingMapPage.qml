import Felgo
import QtQuick
import QtPositioning
import QtLocation as QL
import "../"


AppPage {
  id: root
  title: qsTr("Geocoding")

  AppMap {
    id: appMap

    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    // Configure map provider
    plugin: MapPlugin {}

    QL.MapItemView {
      id: mapItemView
      model: geocodeModel
      delegate: markerDelegate
    }

    // Component used as delegate
    Component {
      id: markerDelegate
      QL.MapQuickItem {
        coordinate: locationData.coordinate
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
  }

  QL.GeocodeModel {
    id: geocodeModel
    plugin: MapPlugin {
    geocoding: true
    }
    autoUpdate: true
    onLocationsChanged: {
      appMap.center = get(0).coordinate
      appMap.zoomLevel = 10
    }
  }

  SearchBar {
    onAccepted: text => {
      geocodeModel.query = text
    }
  }

  AppActivityIndicator {
    id: busyIndicator
    anchors.centerIn: parent
    visible: geocodeModel.status === QL.GeocodeModel.Loading
  }
}
