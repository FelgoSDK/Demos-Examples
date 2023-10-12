import Felgo 3.0
import QtQuick 2.0
import QtLocation 5.12
import QtPositioning 5.12

App {
  AppMap {
    anchors.fill: parent
    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    plugin: Plugin {
      name: system.isPlatform(System.Wasm) ? "mapbox" : "mapboxgl"
      parameters: [
        PluginParameter {
          name: "mapbox.mapping.map_id"
          value: "mapbox/streets-v11"
        },
        PluginParameter {
          name: "mapbox.access_token"
          value: "<accesss_token>" //"pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
        }
      ]
    }
  }
}