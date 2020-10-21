import Felgo 3.0
import QtQuick 2.0
import QtLocation 5.12
import QtPositioning 5.12

Item {
  id: root

  readonly property string activity: internal.activity

  readonly property bool isActive: internal.isActive
  readonly property bool isPaused: internal.isPaused
  readonly property bool isFinished: internal.isFinished

  readonly property int timePassed: internal.timePassed
  readonly property real averageSpeed: internal.averageSpeed
  readonly property real currentAltitude: internal.currentAltitude
  readonly property real distance: internal.distance

  readonly property var path: internal.path

  readonly property string title: internal.title

  signal finished()

  // It's considered to wrap properties into QtObject and create readonly
  // aliases to them. Thanks to that they are kind of private and you can ensure yourself
  // that their values were manipualted intentionally by calling one of functions.
  QtObject {
    id: internal

    property string activity: ""

    property bool isActive: false
    property bool isPaused: false
    property bool isFinished: false

    property int timePassed: 0 // seconds
    property real averageSpeed: {
      if (timePassed == 0) {
        return 0.0
      }

      return distance / (timePassed / 3600)
    }

    property real currentAltitude: 0.0 // meters
    property real distance: 0.0 // km

    property var path: [] // list of coordinates

    property string title: ""

    function updateDistance(coordinate) {
      if (path.length > 0) {
        var caclDistance = path[path.length - 1].distanceTo(coordinate) / 1000

        distance += path[path.length - 1].distanceTo(coordinate) / 1000
      }
    }

    function toObject() {
      var workoutObj = {}

      workoutObj["activity"] = internal.activity;
      workoutObj["timePassed"] = internal.timePassed;
      workoutObj["distance"] = internal.distance;
      workoutObj["path"] = internal.path;
      workoutObj["title"] = internal.title;

      return workoutObj
    }
  }

  Timer {
    id: timePassedTimer

    interval: 1000
    repeat: true
    running: isActive && !isPaused

    onTriggered: {
      internal.timePassed += 1
      storage.setValue("timePassed", root.timePassed)
    }
  }

  Storage {
    id: storage

    function load() {
      // if isFinished is undefined or true don't load other values and keep them default
      const isFinished = storage.getValue("isFinished")
      if (isFinished === undefined || isFinished === true) {
        internal.isFinished = false
        return
      }

      internal.activity = storage.getValue("activity")
      internal.isActive = storage.getValue("isActive")
      internal.isPaused = storage.getValue("isPaused")
      internal.timePassed = storage.getValue("timePassed")
      internal.currentAltitude = storage.getValue("currentAltitude")
      internal.distance = storage.getValue("distance")


      var jsonPath = storage.getValue("path")
      if (jsonPath === undefined) {
        jsonPath = []
      }

      for (const coord of jsonPath) {
        internal.path.push(QtPositioning.coordinate(coord.latitude, coord.longitude))
      }
    }

    function update() {
      storage.setValue("activity", root.activity)
      storage.setValue("isActive", root.activity)
      storage.setValue("isPaused", root.isPaused)
      storage.setValue("isFinished", root.isFinished)
      storage.setValue("timePassed", root.timePassed)
      storage.setValue("currentAltitude", root.currentAltitude)
      storage.setValue("distance", root.distance)
      storage.setValue("path", root.path)
    }

    function cleanWorkout() {
      console.log("in clean")
      storage.clearValue("activity")
      storage.clearValue("isActive")
      storage.clearValue("isPaused")
      storage.clearValue("isFinished")
      storage.clearValue("timePassed")
      storage.clearValue("currentAltitude")
      storage.clearValue("distance")
      storage.clearValue("path")

      internal.isActive = false
      internal.isPaused = false
      internal.isFinished = false

      internal.timePassed = 0
      internal.currentAltitude = 0.0
      internal.distance = 0.0

      internal.path = []
      internal.activity = ""
      internal.title = ""
    }
  }

  function start() {
    internal.isActive = true
    storage.update()
  }

  function pause() {
    internal.isPaused = true
    storage.update()
  }

  function resume() {
    internal.isPaused = false
    storage.update()
  }

  function finish() {
    internal.isFinished = true
    storage.update()
    root.finished()
  }

  function setActivity(activity) {
    internal.activity = activity
    storage.update()
  }

  function addPosition(position) {
    if (position.latitudeValid && position.longitudeValid) {
      internal.updateDistance(position.coordinate)
      internal.path.push(position.coordinate)

      if (position.altitudeValid) {
        internal.currentAltitude = position.coordinate.altitude
      }

      storage.update()
    }
  }

  function save(workoutTitle) {
    internal.title = workoutTitle
    internal.isActive = false

    dataModel.addWorkout(internal.toObject())
    storage.cleanWorkout()
  }

  Component.onCompleted: {
    storage.load()
  }
}
