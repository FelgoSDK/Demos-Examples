import Felgo 3.0
import QtLocation 5.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "AppMap"

      AppMap {
        anchors.fill: parent

        // Configure map provider
        plugin: Plugin {
          name: system.isPlatform(System.Wasm) ? "mapbox" : "mapboxgl"
          // Configure your own map_id and access_token here
          parameters: [  PluginParameter {
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
            }]
        }

        // Configure the map to try to display the user's position
        showUserPosition: true
        zoomLevel: 13

        // Check for user position initially when the component is created
        Component.onCompleted: {
          if (userPositionAvailable) {
            center = userPosition.coordinate
          }
        }

        // Once we successfully received the location, we zoom to the user position
        onUserPositionAvailableChanged: {
          if (userPositionAvailable) {
            zoomToUserPosition()
          }
        }
      }
    }
  }
}
