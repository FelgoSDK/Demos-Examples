import Felgo 3.0
import QtLocation 5.0
import QtPositioning 5.0
import QtQuick 2.0


App {
  color: "black"

  NavigationStack {
    id: navigationStack
    Page {
      id: page
      title: "Plugin"
      property var selectedPlugin: mapboxPlugin

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
          plugin: page.selectedPlugin
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
                displayName: "MapBox"
                name: "mapbox"
              }
              ListElement {
                displayName: "MapBox GL"
                name: "mapboxgl"
              }
              ListElement {
                displayName: "Open Street Map"
                name: "osm"
              }
            }

            delegate: SimpleRow {
              text: displayName

              onSelected: {
                switch (name) {
                case "mapbox":
                  page.selectedPlugin = mapboxPlugin
                  break;
                case "mapboxgl":
                  page.selectedPlugin = mapboxglPlugin
                  break;
                case "osm":
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
        id: mapboxPlugin
        name: "mapbox"

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

      Plugin {
        id: mapboxglPlugin
        name: "mapboxgl"
      }

      Plugin {
        id: osmPlugin
        name: "osm"
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
