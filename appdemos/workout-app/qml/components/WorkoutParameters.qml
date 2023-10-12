import Felgo 3.0
import QtQuick 2.0
import "../Helpers.js" as Helpers
import "../model"


AppPaper {
  id: root

  property Workout workout: null

  width: parent.width
  height: dp(130)

  background.color: Theme.navigationTabBar.backgroundColor

  Behavior on anchors.leftMargin {
    NumberAnimation { duration: 200 }
  }

  Grid {
    width: parent.width
    height: parent.height

    columns: 2

    WorkoutParameterTile {
      title: "Time"
      value: Helpers.formatTime(workout.timePassed)
    }

    WorkoutParameterTile {
      title: "Distance"
      value: workout.distance.toFixed(1) + " km"
    }

    WorkoutParameterTile {
      title: "Avg. speed"
      value: workout.averageSpeed.toFixed(1) + " km/h"
    }

    WorkoutParameterTile {
      title: "Altitude"
      value: workout.currentAltitude.toFixed(1) + " m"
    }
  }
}
