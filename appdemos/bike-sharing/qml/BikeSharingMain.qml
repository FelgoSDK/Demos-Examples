import Felgo 3.0
import QtQuick 2.0
import QtLocation 5.5
import QtPositioning 5.5
import QtQml.Models 2.14

App {
  id: app

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  FontLoader {
    id: latoFont
    source: "../assets/fonts/Lato-Light.ttf"
  }

  onInitTheme: {
    Theme.colors.tintColor = blueLightColor
    Theme.normalFont = latoFont
  }

  // Frequently used colors
  readonly property color blueLightColor: "#0093c9"
  readonly property color blueDarkColor: "#455569"

  // Location of Vienna, AT
  readonly property var vienna: QtPositioning.coordinate(48.208417, 16.372472)

  // Data Model for the Bike stations
  readonly property alias stationsModel: dataModel.stations
  DataModel {
    id: dataModel
    Component.onCompleted: requestStations()
    onStationsLoaded: {
      console.log("Bike stations Loaded!")
      displayedStationsModel.update()
    }
  }

  // Settings
  Storage {
    id: settings
    property var favorites: (getValue(settingsKeyFav) ? getValue(settingsKeyFav) : "1128").split(",")
    readonly property string settingsKeyFav: "fav"

    onFavoritesChanged: {
      console.debug("Favorites changed to", JSON.stringify(favorites))
      if (getValue(settingsKeyFav) !== favorites.join(",")) {
        setValue(settingsKeyFav, favorites.join(","))
      }
      displayedStationsModel.update()
    }

    function isFavorited(stationId) {
      return (favorites.includes(stationId.toString()))
    }

    function toggleFavorite(stationId) {
      stationId = stationId.toString()
      if (!isFavorited(stationId)) {
        favorites.push(stationId)
      } else {
        favorites.splice(favorites.indexOf(stationId), 1)
      }
      favoritesChanged()
    }
  }

  Page {
    useSafeArea: false

    ListModel {
      id: displayedStationsModel

      function update() {
        clear()

        // Find nearest station
        var nearestStationId = getNearestStation()

        // Add favs
        for (var i = 0; i < stationsModel.count; i++) {
          var station = stationsModel.get(i)
          if (settings.isFavorited(station.internalId) && station.internalId !== nearestStationId) {
            append(toDisplayObject(station))
          }
        }
      }

      function toDisplayObject(station) {
        return {
          internalId: station.internalId,
          name: station.name,
          freeBoxes: station.freeBoxes,
          freeBikes: station.freeBikes,
          favorited: settings.isFavorited(station.internalId)
        }
      }

      // Find nearest non-favorited station
      function getNearestStation() {
        if (map.userPositionAvailable) {
          var lowestDistance = Number.MAX_VALUE
          var hlStation = null

          for (var i = 0; i < stationsModel.count; i++) {
            var s = stationsModel.get(i)
            var d = map.userPosition.coordinate.distanceTo(QtPositioning.coordinate(s.latitude, s.longitude))
            if (d < lowestDistance) {
              lowestDistance = d
              hlStation = s
            }
          }

          // Get station
          if (hlStation) {
            set(0, toDisplayObject(hlStation))
            return hlStation.internalId
          }
        }
        return -1
      }
    }


    NavigationStack {
      splitView: false

      Page {
        id: page
        navigationBarHidden: true
        useSafeArea: false

        property bool displayFreeBikes: true
        property int selectedIndex: -1

        onSelectedIndexChanged: {
          var selectedStation = stationsModel.get(selectedIndex)
          if (selectedStation && selectedIndex >= 0) {
            currentStationView.stationName = selectedStation.name
            currentStationView.stationBikes = selectedStation.freeBikes
            currentStationView.stationBoxes = selectedStation.freeBoxes
            currentStationView.stationFavorited = settings.isFavorited(selectedStation.internalId)
          }
        }

        // Header
        Rectangle {
          id: header

          width: parent.width
          height: dp(210) + page.safeArea.insets.top
          // Bring in front of map
          z: 2

          color: "#eeeeee"

          PageControl {
            id: pageControl

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: Theme.statusBarHeight + dp(10)

            opacity: page.selectedIndex >= 0 ? 0 : 1

            pageIcons: map.userPositionAvailable ? ({ 0: IconType.locationarrow }) : ({})

            tintColor: "#dddddd"
            activeTintColor: blueLightColor

            onPageSelected: innerList.scrollToPage(index)
            pages: displayedStationsModel.count
          }

          ListView {
            id: innerList

            onContentXChanged: {
              currentIndex = Math.round(contentX / width)
              pageControl.currentPage = currentIndex
            }

            anchors.fill: parent
            anchors.topMargin: pageControl.y + pageControl.height + dp(10)

            visible: !currentStationView.visible

            model: displayedStationsModel
            orientation: ListView.Horizontal
            snapMode: ListView.SnapOneItem
            highlightFollowsCurrentItem: true

            delegate: StationView {
              width: innerList.width
              height: innerList.height

              stationName: name
              stationBikes: freeBikes
              stationBoxes: freeBoxes
              stationFavorited: favorited || false

              // We don't use the property signal change handler as this one is also emitted when
              // changing the property in code
              onFavoritedPressed: settings.toggleFavorite(internalId)
            }

            function scrollToPage(index) {
              innerList.positionViewAtIndex(index, ListView.SnapPosition)
            }
          }

          StationView {
            id: currentStationView

            anchors.fill: innerList
            visible: page.selectedIndex >= 0

            backVisible: true
            onBackPressed: page.selectedIndex = -1

            // We don't use the property signal change handler as this one is also emitted when
            // changing the property in code
            onFavoritedPressed: {
              var internalId = stationsModel.get(page.selectedIndex).internalId
              settings.toggleFavorite(internalId)
            }
          }

          // Shadow below header
          Rectangle {
            anchors.top: parent.bottom
            width: parent.width
            height: dp(55)

            gradient: Gradient {
              GradientStop { position: 0.0; color: "#33000000" }
              GradientStop { position: 1.0; color: "transparent" }
            }
          }
        }

        AppMap {
          id: map
          width: parent.width
          anchors.top: header.bottom
          anchors.bottom: parent.bottom

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

          // Defaults to Vienna, AT
          center: vienna
          zoomLevel: 15
          Component.onCompleted: {
            map.center = vienna
            map.zoomLevel = 15
          }

          // Click on map -> dismiss current selection
          onMapClicked: page.selectedIndex = -1

          showUserPosition: true
          onUserPositionChanged: displayedStationsModel.getNearestStation()

          // Map markers for stations
          MapItemView {
            model: stationsModel

            delegate: MapQuickItem {
              coordinate: QtPositioning.coordinate(latitude, longitude)

              anchorPoint.x: sourceItem.width * 0.5
              anchorPoint.y: sourceItem.height

              sourceItem: AppImage {
                width: dp(40)
                height: dp(34)

                source: {
                  var availableItems = page.displayFreeBikes ? model.freeBikes : model.freeBoxes
                  if (model.availability !== "aktiv") {
                    return "../assets/pin-grey.png"
                  } else if (availableItems < 1) {
                    return "../assets/pin-red.png"
                  } else if (availableItems <= 2) {
                    return "../assets/pin-orange.png"
                  } else {
                    return "../assets/pin-green.png"
                  }
                }

                MouseArea {
                  anchors.fill: parent
                  onClicked: page.selectedIndex = index
                }
              }
            }
          }
        }

        FloatingActionButton {
          visible: true
          enabled: map.userPositionAvailable
          icon: IconType.locationarrow
          onClicked: map.zoomToUserPosition()
          iconColor: Theme.colors.tintColor
          backgroundColor: "white"
          opacity: enabled ? 1.0 : 0.6
        }
      }
    }
  }
}
