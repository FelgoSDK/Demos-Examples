import Felgo 4.0
import QtQuick 2.14
import QtLocation 5.14

Plugin {
  // Note: Vector maps with MapLibre GL require to use the OpenGL graphics backend
  // Felgo does not force OpenGL on macOS and iOS, as it may cause problems with other Qt components like the Camera or Qt 3D
  // If you do not require such features, you can safely activate OpenGL and use vector maps on all target platforms
  name: {
    if (system.isPlatform(System.Wasm)) {
      return "mapbox"
    } else if (vectorMapNotSupported || geocoding) {
      return "osm"
    }
    return "maplibregl"
  }

  parameters: {
    switch(name) {
    case "mapbox":
      return mapBoxParameters;
    case "osm":
      return osmParameters;
    default:
      return mapLibreParameters;
    }
  }

  property bool vectorMapNotSupported: system.isPlatform(System.Mac) || system.isPlatform(System.IOS) || system.isPlatform(System.Wasm)

  property bool geocoding: false

  property list<PluginParameter> mapLibreParameters: [
    PluginParameter {
      name: "maplibregl.mapping.additional_style_urls"
      value: "https://api.maptiler.com/maps/streets/style.json?key=Po06mqlH0Kut19dceSyI"
    }
  ]

  property list<PluginParameter> osmParameters: [
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

  property list<PluginParameter> mapBoxParameters: [
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
      value: false
    }
  ]
}
