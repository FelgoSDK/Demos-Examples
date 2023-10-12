import QtLocation 5.0
import QtPositioning 5.0
import QtQuick 2.0
import Felgo 3.0


App {
  // We'd like to build pedestrian route from Wien Mitte Mall to Felgo Office
  readonly property var startCoordinate: QtPositioning.coordinate(48.206879, 16.385532) // Wien Mitte Mall
  readonly property var endCoordinate: QtPositioning.coordinate(48.21041, 16.3891) // Felgo Office

  NavigationStack {
    Page {
      title: "MapRoute"

      AppMap {
        id: map
        anchors.fill: parent
        center: endCoordinate

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

        showUserPosition: false
        zoomLevel: 16

        MapRoute {
          id: routeItem
          line {
            color: "indianred"
            width: 5
          }
          smooth: true
          antialiasing: true
          // Invisible by default; will be visible as soon as route will be ready
          visible: false
          opacity: 0.6
        }

        MapQuickItem {
          id: startMarker
          visible: false
          coordinate: startCoordinate
          anchorPoint {
            x: sourceItem.width / 2
            y: sourceItem.height
          }
          sourceItem: Icon {
            icon: IconType.mapmarker
            color: "red"
            size: dp(30)
          }
        }

        MapQuickItem {
          id: destinationMarker
          visible: false
          coordinate: endCoordinate
          anchorPoint {
            x: sourceItem.width / 2
            y: sourceItem.height
          }
          sourceItem: Icon {
            icon: IconType.mapmarker
            color: "red"
            size: dp(30)
          }
        }

        RouteModel {
          id: routeModel
          query: routeQuery
          // Use same map provide as map uses
          plugin: map.plugin

          onStatusChanged: {
            // When model found a route -> show it
            if (status === RouteModel.Ready) {
              routeItem.route = get(0)
              // Passing info about route length
              routeItem.visible = true
              // Clear old route query
              routeQuery.clearWaypoints()
            }
          }
        }

        RouteQuery {
          id: routeQuery
        }

        Component.onCompleted: {
          // Add waypoints to our route
          routeQuery.addWaypoint(startCoordinate)
          routeQuery.addWaypoint(endCoordinate)

          routeItem.visible = true
          startMarker.visible = true
          destinationMarker.visible = true

          routeQuery.travelModes = RouteQuery.PedestrianTravel
          routeModel.update()
        }
      }
    }
  }
}
