import Felgo 3.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5


Page {
  id: root

  property alias path: track.path

  title: qsTr("Workout")

  AppMap {
    id: map

    anchors.fill: parent

    zoomLevel: 13

    plugin: Plugin {
      name: system.isPlatform(System.Wasm) ? "mapbox" : "mapboxgl"

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

    MapPolyline {
      id: track
      line.width: dp(3)
      line.color: Theme.tintColor
    }

    Timer {
      interval: 100
      running: true

      onTriggered: {
        map.fitViewportToVisibleMapItems()
      }
    }
  }
}
