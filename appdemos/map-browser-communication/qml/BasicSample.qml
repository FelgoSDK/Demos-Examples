import Felgo
import QtQuick
import QtLocation
import QtPositioning

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
