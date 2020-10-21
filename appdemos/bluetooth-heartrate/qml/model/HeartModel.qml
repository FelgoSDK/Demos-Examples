import QtQuick 2.0
import Felgo 3.0

QtObject {
  id: heartModel

  property int bpm: -1
  property int upper: 190
  property int lower: 40

  property int min: -1
  property int max: -1
  property int avg: -1

  property bool beating: false

  property QtObject _: QtObject{
    property var shortWindowFilter: ([])   // 10 Second Window
    property var longWindowFilter: ([])   // Last 6 10-Second window record, 1 min avg
    property int longWindowFilterIndex: 0
  }

  property Timer statsTimer: Timer {
    running: beating
    interval: 1000
    repeat: true
    onTriggered: {
      min = min > bpm || min < 0 ? bpm : min
      max = max < bpm ? bpm : max

      // Add a measurement every second
      _.shortWindowFilter.push(bpm)

      // We have a sample window average of 10 samples
      // Average current sample window, store in longWindowFilter and reset
      if(_.shortWindowFilter.length >= 10) {
        _.longWindowFilter[_.longWindowFilterIndex] = _.shortWindowFilter.reduce((sum, sample) => sum += sample)/_.shortWindowFilter.length
        _.shortWindowFilter = []
        _.longWindowFilterIndex++
        _.longWindowFilterIndex = _.longWindowFilterIndex > 5 ? 0 : _.longWindowFilterIndex
        avg = _.longWindowFilter.reduce((sum, sample) => sum += sample)/_.longWindowFilter.length
      }
    }
  }

  function resetStats() {
    _.shortWindowFilter = []
    _.longWindowFilter = []
    _.longWindowFilterIndex = 0
    min = -1
    max = -1
    avg = -1
  }
}
