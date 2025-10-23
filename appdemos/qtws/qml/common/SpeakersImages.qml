import Felgo
import QtQuick

Item {
  id: root

  property var sources: []
  property real offsetPercentage: sources.length > 2 ? 0.24 : 0.3

  readonly property alias loaded: _.loaded
  readonly property alias loading: _.loading

  QtObject {
    id: _
    // duplicated here so the public api can be readonly
    property bool loaded: false
    property bool loading: false

    property real offsetWidth: offsetPercentage * root.width
    property real offsetHeight: offsetPercentage * root.height

    property int loadedCount: 0
  }

  Repeater {
    id: repeater
    model: sources && Array.isArray(sources) ? sources.reverse() : []

    SpeakerImage {
      source: modelData !== undefined ? modelData : ""

      width: root.width - (sources.length - 1) * _.offsetWidth
      height: root.height - (sources.length - 1) * _.offsetHeight

      x: root.width - width - (index * _.offsetWidth)
      y: index * _.offsetHeight

      onLoadingChanged: {
        if (loading && !_.loading) {
          _.loading = true
        }
      }
      onLoadedChanged: {
        if (++_.loadedCount == sources.length) {
          _.loaded = true
          _.loading = false
        }

      }
    }
  }
}
