import Felgo 4.0
import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

import "../"

AppPage {
  id: root
  title: qsTr("Plugin configuration")

  property var selectedPlugin: osmPlugin

  // Note: Vector maps with MapLibre GL require to use the OpenGL graphics backend
  // Felgo does not force OpenGL on macOS and iOS, as it may cause problems with other Qt components like the Camera or Qt 3D
  // If you do not require such features, you can safely activate OpenGL and use vector maps on all target platforms
  property bool vectorMapSupported: !system.isPlatform(System.Mac) && !system.isPlatform(System.IOS) && !system.isPlatform(System.Wasm)


  rightBarItem: TextButtonBarItem {
    text: "Change"

    onClicked: {
      modal.open()
    }
  }

  Loader {
    id: mapLoader
    anchors.fill: parent

    active: false
  }

  Component {
    id: mapComponent
    AppMap {
      anchors.fill: parent

      // Default location is Vienna, AT
      center: QtPositioning.coordinate(48.208417, 16.372472)
      zoomLevel: 10

      Component.onCompleted: plugin = root.selectedPlugin
    }
  }

  AppModal {
    id: modal

    // Set your main content root item
    pushBackContent: navigationStack

    // Add any custom content for the modal
    NavigationStack {
      ListPage {
        title: "Select plugin"
        rightBarItem: TextButtonBarItem {
          text: "Close"
          textItem.font.pixelSize: sp(16)
          onClicked: modal.close()
        }

        model: ListModel {
          ListElement {
            displayName: "Open Street Map"
            name: "osm"
          }
          ListElement {
            displayName: "MapLibre GL"
            name: "maplibregl"
          }
        }

        delegate: SimpleRow {
          text: displayName
          visible: name === "osm" || vectorMapSupported

          onSelected: {
            switch (name) {
            case "maplibregl":
              root.selectedPlugin = maplibreglPlugin
              break;
            case "osm":
              root.selectedPlugin = osmPlugin
              break;
            default:
              console.warn("Plugin not supported")
              break
            }
            root.loadMap()

            modal.close()
          }
        }
      }
    }
  }

  Plugin {
    id: maplibreglPlugin
    name: "maplibregl"

    parameters: [
      PluginParameter {
        name: "maplibregl.mapping.additional_style_urls"
        value: "https://api.maptiler.com/maps/streets/style.json?key=Po06mqlH0Kut19dceSyI"
      }
    ]
  }

  Plugin {
    id: osmPlugin
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

  Component.onCompleted: {
    root.loadMap()
  }

  function loadMap() {
    mapLoader.sourceComponent = null
    mapLoader.active = false
    mapLoader.sourceComponent = mapComponent
    mapLoader.active = true
  }
}
