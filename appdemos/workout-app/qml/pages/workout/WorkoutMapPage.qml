import Felgo 4.0
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.5
import "../../components"
import "../../model"


AppPage {
  id: root

  property Workout workout: Workout { }
  property bool workoutParametersVisible: root.workout.isActive

  signal closedButtonClicked()

  title: root.workout.activity

  rightBarItem: TextButtonBarItem {
    color: Theme.tintColor
    text: root.workout.isActive ? qsTr("Hide") : qsTr("Close")
    textItem.font.pixelSize: sp(16)
    onClicked: {
      root.closedButtonClicked()
    }
  }

  AppMap {
    id: map

    anchors {
      fill: parent
      bottomMargin: footer.height
    }

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

    center: userPosition.coordinate
    zoomLevel: 13
    showUserPosition: true
    enableUserPosition: true


    MapPolyline {
      id: track
      line.width: dp(5)
      line.color: Theme.tintColor

      path: root.workout.path
    }

    Component.onCompleted: {
      zoomToUserPosition()
    }

    onUserPositionChanged: {
      // we track activity only if this condition is accomplished
      if (root.workout.isActive && !root.workout.isPaused && !root.workout.isFinished) {
        root.workout.addPosition(userPosition)

        if (userPosition.latitudeValid && userPosition.longitudeValid) {
          track.addCoordinate(userPosition.coordinate)
        }
      }
    }

    MouseArea {
      anchors.fill: parent
      visible: root.workoutParametersVisible

      onEntered: {
        root.workoutParametersVisible = false
      }
    }
  } // map

  Rectangle {
    id: stoppedMessage

    anchors {
      top: parent.top
      topMargin: root.workout.isPaused ? 0 : - height
    }

    Behavior on anchors.topMargin {
      NumberAnimation { duration: 200 }
    }

    width: parent.width
    height: dp(30)

    color: "#EA004FAC"

    AppText {
      anchors.centerIn: parent

      color: "white"
      font.letterSpacing: 1
      fontSize: 11
      text: qsTr("STOPPED")
    }
  } // stopped message

  WorkoutParameters {
    id: workoutParametersContainer

    anchors {
      bottom: footer.top
      left: parent.left
      leftMargin: root.workoutParametersVisible ? 0 : - width
    }

    workout: root.workout
  } // workout parameters container

  AppPaper {
    id: footer

    anchors.bottom: parent.bottom
    width: parent.width
    height: dp(130)

    background.color: Theme.navigationTabBar.backgroundColor
    shadow.visible: !root.workoutParametersVisible

    RoundedButton {
      id: resumeButton

      anchors {
        centerIn: parent
        horizontalCenterOffset: root.workout.isPaused ? - dp(45) : 0
      }
      visible: anchors.horizontalCenterOffset != 0

      backgroundColor: Theme.navigationTabBar.backgroundColor
      backgroundColorPressed: backgroundColor
      borderColor: Theme.tintColor
      borderColorPressed: borderColor
      borderWidth: 2
      textColor: Theme.tintColor
      textColorPressed: textColor

      text: qsTr("RESUME")

      onClicked: {
        root.workout.resume()
      }
    }

    RoundedButton {
      id: startPauseFinishButton

      anchors {
        centerIn: parent
        horizontalCenterOffset: root.workout.isPaused ? dp(45) : 0
      }

      backgroundColor: Theme.tintColor
      backgroundColorPressed: backgroundColor
      iconType: root.workout.isActive && !root.workout.isPaused ? IconType.stop : ""
      text: root.workout.isActive ? root.workout.isPaused ? qsTr("FINISH") : "" : qsTr("START")
      textColor: Theme.navigationTabBar.backgroundColor
      textColorPressed: textColor

      onClicked: {
        if (!workout.isActive) {
          root.workout.start()
          navigation.currentIndex = 0
          return
        }

        if (root.workout.isActive && !root.workout.isPaused) {
          root.workoutParametersVisible = true
          root.workout.pause()
          return
        }

        if (root.workout.isPaused) {
          root.workout.finish()
          root.navigationStack.push(workoutSavePageComponent, {"workout": root.workout})
          return
        }
      }
    }

    RoundedButton {
      id: workoutParametersButton

      anchors {
        horizontalCenter: parent.horizontalCenter
        horizontalCenterOffset: parent.width * 0.4
        verticalCenter: parent.verticalCenter
      }

      minimumWidth: pressed ? dp(34) : dp(40)
      minimumHeight: minimumWidth

      iconType: IconType.mapmarker

      backgroundColor: root.workoutParametersVisible ? Theme.navigationTabBar.backgroundColor : Theme.tintColor
      backgroundColorPressed: backgroundColor
      borderColor: Theme.tintColor
      borderColorPressed: borderColor
      borderWidth: 2
      textColor: root.workoutParametersVisible ? Theme.tintColor : Theme.navigationTabBar.backgroundColor
      textColorPressed: textColor

      onClicked: {
        root.workoutParametersVisible = !root.workoutParametersVisible
      }
    }
  } // footer
}
