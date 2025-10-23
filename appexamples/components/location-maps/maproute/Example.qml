import QtLocation
import QtPositioning
import QtQuick
import Felgo


App {
  // We'd like to build pedestrian route from Wien Mitte Mall to Felgo Office
  readonly property var startCoordinate: QtPositioning.coordinate(48.206879, 16.385532) // Wien Mitte Mall
  readonly property var endCoordinate: QtPositioning.coordinate(48.21041, 16.3891) // Felgo Office

  NavigationStack {
    AppPage {
      title: "MapRoute"

      AppMap {
        id: map
        anchors.fill: parent
        center: endCoordinate

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
          name: "maplibre"

          // Set your own map_id and access_token here
          parameters: [
            PluginParameter {
              name: "maplibre.map.styles"
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
          sourceItem: AppIcon {
            iconType: IconType.mapmarker
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
          sourceItem: AppIcon {
            iconType: IconType.mapmarker
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
