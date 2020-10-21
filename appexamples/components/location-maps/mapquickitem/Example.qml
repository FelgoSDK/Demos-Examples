import Felgo 3.0
import QtLocation 5.0
import QtPositioning 5.0
import QtQuick 2.0


App {
  // Felgo Vienna office coordinate (lat, lon)
  readonly property var officeCoordinate: QtPositioning.coordinate(48.21041, 16.3891)

  NavigationStack {
    Page {
      title: "MapQuickItem"

      AppMap {
        anchors.fill: parent

        // Configure map provider
        plugin: Plugin {
          name: system.isPlatform(System.Wasm) ? "mapbox" : "mapboxgl"
          // Configure your own map_id and access_token here
          parameters: [  PluginParameter {
              name: "mapbox.mapping.map_id"
              value: "mapbox.streets"
            },
            PluginParameter {
              name: "mapbox.access_token"
              value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
            },
            PluginParameter {
              name: "mapbox.mapping.highdpi_tiles"
              value: true
            }]
        }

        showUserPosition: false
        zoomLevel: 13

        Component.onCompleted: {
          center = officeCoordinate
        }

        MapQuickItem {
          id: marker
          coordinate: officeCoordinate
          anchorPoint {
            x: circle.width / 2
            y: circle.height / 2
          }

          sourceItem: Rectangle {
            id: circle
            width: dp(80)
            height: width
            radius: width / 2
            border {
              width: dp(3)
              color: "darkslategray"
            }
            color: "darkseagreen"
            opacity: 0.7
          }
        }
      }
    }
  }
}
