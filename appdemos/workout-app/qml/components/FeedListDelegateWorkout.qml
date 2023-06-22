import Felgo 4.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5


AppMap {
  id: map

  width: parent.width
  height: dp(250)

  gesture.enabled: false
  zoomLevel: 8

  // Note: Vector maps with MapLibre GL require to use the OpenGL graphics backend
  // Felgo does not force OpenGL on macOS and iOS, as it may cause problems with other Qt components like the Camera or Qt 3D
  // If you do not require such features, you can safely activate OpenGL and use vector maps on all target platforms
  plugin: {
    if (system.isPlatform(System.Wasm)) {
      return mapboxPlugin
    } else if (system.isPlatform(System.Mac) || system.isPlatform(System.IOS)) {
      return osmPlugin
    }
    return mapLibrePlugin
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
    id: mapLibrePlugin
    name: "maplibregl"

    // Set your own map_id and access_token here
    parameters: [
      PluginParameter {
        name: "maplibregl.mapping.additional_style_urls"
        value: "https://api.maptiler.com/maps/streets/style.json?key=Po06mqlH0Kut19dceSyI"
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

  MapPolyline {
    id: track
    line.width: dp(3)
    line.color: Theme.tintColor

    path: modelItem.workout.path
    visible: modelItem.workout.path.length > 0
  }

  Timer {
    interval: 100
    running: true

    onTriggered: {
      map.fitViewportToVisibleMapItems()
    }
  }

  MouseArea {
    anchors.fill: parent

    onClicked: {
      navigationStack.push(feedMapPageComponent, {"path": modelItem.workout.path})
    }
  }
}
