import Felgo 3.0
import QtQuick 2.0
import QtLocation 5.5
import QtPositioning 5.5


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
    Theme.colors.tintColor = Qt.rgba(0, 147/256.0, 201/256.0, 1)
    Theme.normalFont = latoFont
  }

  // Custom colors
  readonly property color blueLightColor: Qt.rgba(0, 147/256.0, 201/256.0, 1)
  // Generic text blue color
  readonly property color blueDarkColor: Qt.rgba(69/256.0, 85/256.0, 105/256.0, 1)
  // Background grey
  readonly property color greyBackgroundColor: Qt.rgba(238/256.0, 238/256.0, 238/256.0, 1)
  // Grey line color
  readonly property color greyLineColor: Qt.rgba(221/256.0, 221/256.0, 221/256.0, 1)

  // Data Model for the Bike Stations
  readonly property alias stationsModel: dataModel.stationsModel
  DataModel {
    id: dataModel
    Component.onCompleted: requestStations()
    onStationsLoaded: {
      console.log("Stations Loaded!")
      favsModel.update()
    }
  }

  // Settings
  Storage {
    id: settings
    readonly property string keyForFav: "fav"

    property var favorites: (getValue(keyForFav) ? getValue(keyForFav) : "1128").split(",")
    onFavoritesChanged: {
      console.debug("Updated favorites", JSON.stringify(favorites))
      if (getValue(keyForFav) !== favorites.join(",")) {
        setValue(keyForFav, favorites.join(","))
      }
      favsModel.update()
    }

    function isFavorited(internalId) {
      return (favorites.includes(internalId.toString()))
    }

    function toggleFavorite(internalId) {
      internalId = internalId.toString()
      if (!isFavorited(internalId)) {
        favorites.push(internalId)
      } else {
        favorites.splice(favorites.indexOf(internalId), 1)
      }
      favoritesChanged()
    }
  }

  Page {
    useSafeArea: false

    ListModel {
      id: favsModel

      function update() {
        clear()

        // Nearest from GPS coords
        updateNearest()

        // Add favs
        for (var i = 0; i < stationsModel.count; i++) {
          const station = stationsModel.get(i)
          if (settings.isFavorited(station.internalId)) {
            append({
                     internalId: station.internalId,
                     name: station.name,
                     freeBoxes: station.freeBoxes,
                     freeBikes: station.freeBikes,
                     favorited: settings.isFavorited(station.internalId)
                   })
          }
        }
      }

      function updateNearest() {
        if (!map.userPositionAvailable)
          return

        // Compare current user location with all other stations
        var currentDistance = -1
        var currentIndex = -1

        for (var i = 0; i < stationsModel.count; i++) {
          const station = stationsModel.get(i)

          const distance = map.userPosition.coordinate.distanceTo(QtPositioning.coordinate(station.latitude, station.longitude))
          if (currentDistance === -1 || distance < currentDistance) {
            currentDistance = distance
            currentIndex = i
          }
        }

        // Get station
        if (currentIndex !== -1) {
          const s = stationsModel.get(currentIndex)

          set(0, {
                internalId: s.internalId,
                name: s.name,
                freeBoxes: s.freeBoxes,
                freeBikes: s.freeBikes,
                favorited: settings.isFavorited(s.internalId)
              })
        }
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
          const selectedStation = stationsModel.get(selectedIndex)
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

          color: greyBackgroundColor

          PageControl {
            id: pageControl

            anchors {
              horizontalCenter: parent.horizontalCenter
              top: parent.top
              topMargin: Theme.statusBarHeight + dp(10)
            }

            opacity: page.selectedIndex >= 0 ? 0 : 1

            pageIcons: map.userPositionAvailable ? ({ 0: IconType.locationarrow }) : ({})

            tintColor: greyLineColor
            activeTintColor: blueLightColor

            onPageSelected: {
              innerList.scrollToPage(index)
            }

            pages: favsModel.count
          }

          ListView {
            id: innerList

            onContentXChanged: {
              currentIndex = Math.round(contentX / width)
              pageControl.currentPage = currentIndex
            }

            anchors {
              fill: parent
              topMargin: pageControl.y + pageControl.height + dp(10)
            }

            visible: !currentStationView.visible

            model: favsModel
            orientation: ListView.Horizontal
            snapMode: ListView.SnapOneItem
            highlightFollowsCurrentItem: true

            delegate: StationView {
              width: innerList.width
              height: innerList.height

              stationName: name
              stationBikes: freeBikes
              stationBoxes: freeBoxes
              stationFavorited: favorited

              // We don't use the property signal change handler as this one is also emitted when
              // changing the property in code
              onFavoritedPressed: settings.toggleFavorite(internalId)
            }

            function scrollToPage(index) {
              // TODO: Animate
              innerList.positionViewAtIndex(index, ListView.SnapPosition)
            }
          }

          StationView {
            id: currentStationView
            anchors.fill: innerList

            visible: page.selectedIndex >= 0

            backVisible: true

            onBackPressed: {
              page.selectedIndex = -1
            }

            // We don't use the property signal change handler as this one is also emitted when
            // changing the property in code
            onFavoritedPressed: {
              var internalId = stationsModel.get(page.selectedIndex).internalId
              settings.toggleFavorite(internalId)
            }
          }

          // Drop a shadow on bottom of header
          Rectangle {
            anchors.top: parent.bottom
            width: parent.width
            height: dp(5)

            gradient: Gradient {
              GradientStop { position: 0.0; color: "#33000000" }
              GradientStop { position: 1.0; color: "transparent" }
            }
          }
        }

        AppMap {
          id: map

          anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
          }
          showUserPosition: true

          plugin: Plugin {
            name: system.isPlatform(System.Wasm) ? "mapbox" : "mapboxgl"

            // Set your own map_id and access_token here
            parameters: [
              PluginParameter {
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
              }
            ]
          }

          // Defaults to Vienna, AT
          center: QtPositioning.coordinate(48.208417, 16.372472)
          zoomLevel: 15
          Component.onCompleted: {
            map.center = QtPositioning.coordinate(48.208417, 16.372472)
            map.zoomLevel = 15
          }

          onMapClicked: {
            // Clicked on map, remove current selection
            page.selectedIndex = -1
          }

          onUserPositionChanged: {
            favsModel.updateNearest()
          }

          // Station markers
          MapItemView {
            model: stationsModel

            delegate: MapQuickItem {
              coordinate: QtPositioning.coordinate(latitude, longitude)

              anchorPoint.x: image.width * 0.5
              anchorPoint.y: image.height

              sourceItem: AppImage {
                id: image

                width: dp(40)
                height: dp(34)

                source: {
                  // Inactive
                  if (availability !== "aktiv") {
                    return "../assets/pin-grey.png"
                  }

                  var freeItems = page.displayFreeBikes ? freeBikes : freeBoxes

                  if (freeItems === 0) {
                    return "../assets/pin-red.png"
                  }
                  else if (freeItems <= 2) {
                    return "../assets/pin-orange.png"
                  }
                  else {
                    return "../assets/pin-green.png"
                  }
                }

                MouseArea {
                  anchors.fill: parent
                  onClicked: {
                    page.selectedIndex = index
                  }
                }
              }
            }
          }
        }

        IconButton {
          icon: IconType.locationarrow
          anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: dp(10)
            bottomMargin: dp(10)
          }

          enabled: map.userPositionAvailable

          size: dp(26)

          onClicked: {
            map.zoomToUserPosition()
          }
        }
      }
    }
  }
}
