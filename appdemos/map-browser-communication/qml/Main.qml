import Felgo
import QtQuick
import QtLocation
import QtPositioning
import "."

App {

  readonly property bool isWasm: system.isPlatform(System.Wasm)
  readonly property bool showQmlInputs: !isWasm

  onInitTheme: {
    Theme.navigationBar.backgroundColor = "#FE3434"
  }

  webObjects: [
    QtObject {
      id: sharedRouteHandler
      property string from
      property string to
      property int length

      function doSearch() {
        doGeocodeAndRoute(from, to)
      }
    }
  ]

  NavigationStack {
    AppPage {
      title: "Routing"

      AppMap {
        id: appMap
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
          bottom: inputs.visible ? inputs.top : parent.bottom
        }

        plugin: MapPlugin { }

        // Default location is Vienna, AT
        center: QtPositioning.coordinate(48.208417, 16.372472)
        zoomLevel: 10

        MapMarker {
          id: originMarker
          iconType: IconType.mapmarker
          color: fromSearch.iconColor
        }

        MapMarker {
          id: destinationMarker
          iconType: IconType.flag
          color: toSearch.iconColor
        }

        MapRoute {
          id: routeItem
          visible: false
          opacity: 0.6
          smooth: true
          antialiasing: true
          line {
            color: fromSearch.iconColor
            width: 5
          }

          function hide() {
            originMarker.visible = false
            destinationMarker.visible = false
            routeItem.visible = false
            routeModel.reset()
          }
        }

        onUserPositionAvailableChanged: {
          if(userPositionAvailable && enableUserPosition) {
            zoomToUserPosition()
          }
        }
      }

      // Routing backend
      RouteModel {
        id: routeModel
        autoUpdate: false
        query: RouteQuery { }
        plugin: MapPlugin {
          geocoding: true
        }
        onStatusChanged: {
          //When model found a route pass show it
          if (status == RouteModel.Ready) {
            routeItem.route = get(0)
            //Passing info about route length
            routeLengthLabel.routeLength = get(0).distance
            routeItem.visible = true

            //Clear old route query
            routeModel.query.clearWaypoints()
            appMap.fitViewportToMapItems([originMarker, destinationMarker])
          }
        }
      }

      // Geocoding Backend
      GeocodeModel {
        id: geocodeModel
        // Set isFrom so geocodeModel knows if the request was for start or destination
        property bool isFrom: true
        // Before query may set nextQuery to trigger i.e. destination geocode after start geocode
        property var nextQuery: [false, ""]
        autoUpdate: true
        plugin: MapPlugin {
          geocoding: true
        }

        onLocationsChanged: {
          routeItem.hide()

          // Update Marker with results from GeoCoder
          let marker = isFrom ? originMarker : destinationMarker
          marker.coordinate = get(0).coordinate
          marker.visible = true

          // When nextQuery is set, load into geocoder
          if (nextQuery[1]) {
            let d = nextQuery
            nextQuery = [false, ""]
            isFrom = d[0]
            geocodeModel.query = d[1]
          } else if (originMarker.coordinate && destinationMarker.coordinate){ // Trigger routing
            originMarker.visible = destinationMarker.visible = true
            routeModel.query.addWaypoint(originMarker.coordinate)
            routeModel.query.addWaypoint(destinationMarker.coordinate)
            routeModel.update()
          }
        }
      }

      // Show length of route in km
      AppText {
        id: routeLengthLabel
        anchors {
          right: inputs.right
          bottom: showQmlInputs ? inputs.top : parent.top
          bottomMargin: showQmlInputs ? 0 : -height
        }

        property real routeLength: 100
        readonly property string routeLengthText: (routeLength/1000).toFixed(1) + " km"

        color: fromSearch.iconColor
        font.bold: true
        text: "  Route length " + routeLengthText + "  "
        visible: routeLength > 0

        onRouteLengthTextChanged: {
          sharedRouteHandler.length = (routeLength/1000).toFixed(1)
        }

        Rectangle {
          color: "white"
          anchors.fill: routeLengthLabel
          z: -1
        }
      }

      // Loading indicator
      AppActivityIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: routeModel.status === RouteModel.Loading || geocodeModel.status === GeocodeModel.Loading
      }

      // Enable user location crosshair button
      IconButton {
        iconType: IconType.crosshairs
        color: "#FE3434"
        selectedColor: Qt.lighter(color, 1.3)
        anchors {
          bottom: inputs.top
          right: parent.right
          rightMargin: dp(10)
        }
        onClicked: {
          appMap.enableUserPosition = true
          appMap.showUserPosition = true
          if(appMap.userPositionAvailable) {
            appMap.zoomToUserPosition()
          }
        }
      }

      // Input fields
      Column {
        id: inputs
        visible: showQmlInputs

        anchors {
          bottom: parent.bottom
          left: parent.left
          right: parent.right
          topMargin: dp(4)
          leftMargin: dp(4)
          rightMargin: dp(4)
          bottomMargin: nativeUtils.safeAreaInsets.bottom + dp(4)
        }

        SearchBar {
          id: fromSearch
          width: parent.width
          iconType: "●"
          iconColor: "red"
          placeHolderText: "From"

          onAccepted: text => {
            geocodeModel.isFrom = true
            geocodeModel.query = text
          }
        }
        SearchBar {
          id: toSearch
          width: parent.width
          iconType: "●"
          iconColor: "darkred"
          placeHolderText: "To"

          onAccepted: text => {
            geocodeModel.isFrom = false
            geocodeModel.query = text
          }
        }
      }
    }
  }

  // Geocode from & to and route
  function doGeocodeAndRoute(fromAddress, toAddress) {
    routeItem.hide()

    // Tell Geocoder to query from, also queue toAdress
    geocodeModel.isFrom = true
    geocodeModel.nextQuery = [false, toAddress]
    geocodeModel.query = fromAddress

    // Update Input, just in case the input didn't come from these fields
    fromSearch.text = fromAddress
    toSearch.text = toAddress
  }

  // Preconfigured start and destination - automatically geocoded & routed
  Component.onCompleted: {
    doGeocodeAndRoute("Lindhofstrasse 7, 5020 Salzburg", "Kolonitzgasse 9, 1030 Wien")
  }
}
