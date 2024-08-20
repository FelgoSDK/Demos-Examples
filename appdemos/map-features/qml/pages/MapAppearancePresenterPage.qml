import Felgo 4.0
import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12
import "../"


AppPage {
  id: root
  title: qsTr("Map appearance")

  property int mapTypeIndex: 0

  rightBarItem: NavigationBarRow {
    IconButtonBarItem {
      iconType: IconType.chevronleft
      enabled: mapTypeIndex > 0
      color: !enabled ? Theme.disabledColor : Theme.navigationBar.itemColor
      onClicked: {
        mapTypeIndex--
      }
    }

    IconButtonBarItem {
      iconType: IconType.chevronright
      enabled: mapTypeIndex < (appMap.supportedMapTypes.length - 1)
      color: !enabled ? Theme.disabledColor : Theme.navigationBar.itemColor
      onClicked: {
        mapTypeIndex++
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
    plugin: Plugin {
      name: "osm"
      parameters: [
        PluginParameter {
          name: "osm.mapping.highdpi_tiles"
          value: true
        },
        PluginParameter {
          name: "osm.mapping.providersrepository.disabled"
          value: "true"
        },
        PluginParameter {
          name: "osm.mapping.providersrepository.address"
          value: "http://maps-redirect.qt.io/osm/5.6/"
        }
      ]
    }
  }
}
