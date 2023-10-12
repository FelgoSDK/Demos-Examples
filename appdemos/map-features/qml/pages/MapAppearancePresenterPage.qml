import Felgo 3.0
import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import "../"


Page {
  id: root
  title: qsTr("Map apperance")

  // MapBox types 0 and 1 look in the same way, so we just ignore 0 and start with 1
  property int mapTypeIndex: 1

  rightBarItem: NavigationBarRow {
    IconButtonBarItem {
      icon: IconType.chevronleft

      onClicked: {
        mapTypeIndex = (mapTypeIndex === 0) ? appMap.supportedMapTypes.length - 1 : mapTypeIndex - 1
      }
    }

    IconButtonBarItem {
      icon: IconType.chevronright

      onClicked: {
        mapTypeIndex = (mapTypeIndex + 1) % appMap.supportedMapTypes.length
      }
    }
  }

  AppMap {
    id: appMap
    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    activeMapType: supportedMapTypes[root.mapTypeIndex]

    // Configure map provider
    plugin: MapBoxPlugin {}
  }
}
