import QtQuick


Item {
  id: root

  // total distance passed in all activities
  property real totalDistance: 0
  // total distance passed in particular activity
  property var activityDistanceMap: {
    "Run": 0,
    "Ride": 0,
    "Swim": 0,
    "Canoe": 0
  }

  signal loaded()

  Connections {
    target: dataModel

    function onCountChanged() {
      root.load()
    }
  }

  Component.onCompleted: {
    root.load()
  }

  function load() {
    root.totalDistance = 0
    for (const key in root.activityDistanceMap) {
      root.activityDistanceMap[key] = 0
    }

    for (var i = 0; i < dataModel.count; ++i) {
      const entry = dataModel.get(i)
      if (entry.type === "Workout" && entry.author === "currentUser") {
        const distance = entry.workout.distance

        root.totalDistance += distance
        root.activityDistanceMap[entry.workout.activity] += distance
      }
    }

    root.loaded()
  }
}
