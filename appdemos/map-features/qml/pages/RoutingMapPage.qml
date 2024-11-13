import Felgo 4.0
import QtQuick 2.12
import QtPositioning 5.12
import QtLocation 5.12 as QL
import "../"


AppPage {
  id: root
  title: qsTr("Routing")

  rightBarItem: TextButtonBarItem {
    text: "Clear"
    visible: routeItem.visible

    onClicked: {
      routeItem.hide()
      mapMouseArea.isSettingStartMarker = true
    }
  }

  AppMap {
    id: appMap

    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    // Configure map provider
    plugin: MapPlugin {}

    // Route visualization item
    QL.MapRoute {
      id: routeItem
      opacity: 0.6
      smooth: true
      antialiasing: true
      visible: false
      line {
        color: "cornflowerblue"
        width: 5
      }

      function hide() {
        startMarker.visible = false
        destinationMarker.visible = false
        routeItem.visible = false
        routeModel.reset()
      }
    }

    QL.MapQuickItem {
      id: startMarker
      visible: false
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

    QL.MapQuickItem {
      id: destinationMarker
      visible: false
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

    MouseArea {
      id: mapMouseArea

      property bool isSettingStartMarker: true

      anchors.fill: parent
      enabled: routeModel.status !== QL.RouteModel.Loading

      onPressAndHold: mouse => {
        var coordinates = appMap.toCoordinate(Qt.point(mouse.x, mouse.y))
        if (isSettingStartMarker) {
          // Hiding old route
          routeItem.hide()

          routeQuery.addWaypoint(coordinates)
          startMarker.coordinate = coordinates
          startMarker.visible = true
          isSettingStartMarker = false
        } else {
          routeQuery.addWaypoint(coordinates)
          destinationMarker.coordinate = coordinates
          destinationMarker.visible = true
          isSettingStartMarker = true
        }

        /*
        If start and destination marker are set
        the route model need to be updated
        */
        if (routeQuery.waypoints.length >= 2){
          routeQuery.travelModes = QL.RouteQuery.CarTravel
          routeModel.update()
        }
      }
    }
  }


  QL.RouteModel {
    id: routeModel
    plugin: MapPlugin {
      geocoding: true
    }
    autoUpdate: false
    query: routeQuery

    onStatusChanged: {
      //When model found a route pass show it
      if (status == QL.RouteModel.Ready) {
        routeItem.route = get(0)
        //Passing info about route length
        routeLengthLabel.routeLength = get(0).distance
        routeItem.visible = true

        //Clear old route query
        routeQuery.clearWaypoints()
      }
    }
  }

  QL.RouteQuery {
    id: routeQuery
  }

  AppPaper {
    height: routeLengthLabel.height
    anchors {
      bottom: parent.safeArea.bottom
      left: parent.left
      right: parent.right
      margins: dp(10)
    }

    AppText {
      id: routeLengthLabel

      property real routeLength: 0

      width: parent.width

      padding: 15
      horizontalAlignment: Text.AlignHCenter
      text: routeItem.visible ?
              qsTr("Route length ") + (routeLength/1000).toFixed(1) + " km" :
              qsTr("Hold anywhere on the map to add waypoint")
    }
  }

  AppActivityIndicator {
    id: busyIndicator
    anchors.centerIn: parent
    visible: routeModel.status === QL.RouteModel.Loading
  }
}
