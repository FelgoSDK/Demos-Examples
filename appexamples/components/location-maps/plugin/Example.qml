import Felgo 4.0
import QtLocation 5.0
import QtPositioning 5.0
import QtQuick 2.0


App {
  color: "black"

  NavigationStack {
    id: navigationStack
    AppPage {
      id: page
      title: "Plugin"
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
          Component.onCompleted: plugin = page.selectedPlugin
        }
      }

      AppModal {
        id: modal
        // Set your main content page item
        pushBackContent: navigationStack
        // Add any custom content for the modal
        NavigationStack {
          ListPage {
            title: "Select plugin"
            rightBarItem: TextButtonBarItem {
              text: "Close"
              textItem.font.pixelSize: sp(16)
              onClicked: {
                modal.close()
              }
            }

            model: ListModel {
              ListElement {
                displayName: "MapLibre GL"
                name: "maplibregl"
              }
              ListElement {
                displayName: "Open Street Map"
                name: "osm"
              }
            }

            delegate: SimpleRow {
              text: displayName
              visible: name === "osm" || page.vectorMapSupported

              onSelected: {
                switch (name) {
                case "maplibregl":
                  page.selectedPlugin = maplibreglPlugin
                  break;
                case "osm":
                  page.selectedPlugin = osmPlugin
                  break;
                case "mapbox":
                  page.selectedPlugin = osmPlugin
                  break;
                default:
                  console.warn("Plugin not supported")
                  break
                }
                page.loadMap()
                modal.close()
              }
            }
          }
        }
      }

      Plugin {
        id: maplibreglPlugin
        name: "mapboxgl"

        // Set your own map_id and access_token here
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

      Plugin {
        id: mapboxPlugin
        name: "mapbox"

        // Set your own map_id and access_token here
        parameters: [
          PluginParameter {
            name: "mapbox.mapping.map_id"
            value: "mapbox/streets-v11"
          },
          PluginParameter {
            name: "mapbox.access_token"
            value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
          },
          PluginParameter {
            name: "mapbox.mapping.highdpi_tiles"
            value: true
          }
        ]
      }

      Component.onCompleted: {
        page.loadMap()
      }

      function loadMap() {
        mapLoader.sourceComponent = null
        mapLoader.active = false
        mapLoader.sourceComponent = mapComponent
        mapLoader.active = true
      }
    }
  }
}
