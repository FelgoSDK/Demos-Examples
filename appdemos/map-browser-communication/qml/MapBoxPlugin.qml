import Felgo 3.0
import QtQuick 2.14
import QtLocation 5.14

Plugin {
  id: plugin
  name: system.isPlatform(System.Wasm) || geocoding ? "mapbox" : "mapboxgl"
  property bool geocoding

  // Set your own map_id and access_token here
  parameters: [
    PluginParameter {
      name: "mapbox.mapping.map_id"
      value: plugin.name == "mapbox" ? "mapbox/streets-v11" : "mapbox.streets"
    },
    PluginParameter {
      name: "mapbox.access_token"
      value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
    }
  ]
}