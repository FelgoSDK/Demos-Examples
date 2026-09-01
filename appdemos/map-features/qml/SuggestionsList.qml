import Felgo
import QtQuick

AppListView {
  id: root

  property real rowHeight: dp(30)
  property int fontPixelSize: sp(14)

  signal proposalSelected(string suggestion)

  height: 0
  visible: false
  clip: true

  boundsBehavior: Flickable.StopAtBounds

  delegate: SimpleRow {
    height: root.rowHeight
    text: suggestion

    onSelected: {
      root.proposalSelected(suggestion)
    }
  }

  PropertyAnimation {
    id: showHideAnimation

    target: root

    property: "height"
    duration: 300
  }

  function show() {
    if (!visible) {
      visible = true
      showHideAnimation.to = root.rowHeight * 4
      showHideAnimation.start()
    }
  }

  function hide() {
    if (visible) {
      visible = false
      showHideAnimation.to = 0
      showHideAnimation.start()
    }
  }
}
