import QtLocation 5.0
import QtPositioning 5.0
import QtQuick 2.0
import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "PositionSource"

      PositionSource {
        id: positionSource
        updateInterval: 300
        active: true
      }

      AppMap {
        MapQuickItem {
          id: marker
          coordinate: positionSource.position.coordinate
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
            opacity: 0.6
          }
          visible: true

          Icon {
            anchors.centerIn: parent
            icon: IconType.male
            color: "navy"
          }
        }

        anchors.fill: parent
        center: positionSource.position.coordinate

        // Configure map provider
        plugin: Plugin {
          name: "mapbox"
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

        // Configure the map to try to display the user's position
        showUserPosition: false
        zoomLevel: 13
      }
    }
  }
}
