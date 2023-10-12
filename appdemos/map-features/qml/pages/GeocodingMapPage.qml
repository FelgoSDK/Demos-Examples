import Felgo 3.0
import QtQuick 2.12
import QtPositioning 5.12
import QtLocation 5.12 as QL
import "../"


Page {
  id: root
  title: qsTr("Geocoding")

  AppMap {
    id: appMap

    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    // Configure map provider
    plugin: MapBoxPlugin {}

    QL.MapItemView {
      id: mapItemView
      model: geocodeModel
      delegate: markerDelegate
    }

    // Component used as delagate
    Component {
      id: markerDelegate
      QL.MapQuickItem {
        coordinate: locationData.coordinate
        anchorPoint {
          x: sourceItem.width / 2
          y: sourceItem.height
        }

        sourceItem: Icon {
          icon: IconType.mapmarker
          color: "red"
          size: dp(30)
        }
      }
    }
  }

  QL.GeocodeModel {
    id: geocodeModel
    plugin: MapBoxPlugin {
    geocoding: true
    }
    autoUpdate: true
    onLocationsChanged: {
      appMap.center = get(0).coordinate
      appMap.zoomLevel = 10
    }
  }

  SearchBar {
    onAccepted: {
      geocodeModel.query = text
    }
  }

  AppActivityIndicator {
    id: busyIndicator
    anchors.centerIn: parent
    visible: geocodeModel.status === QL.GeocodeModel.Loading
  }
}
