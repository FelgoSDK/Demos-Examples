import Felgo 4.0
import QtQuick 2.0


Rectangle {
  id: root

  readonly property real calculatedHeight: titleSection.height + contentColumn.height + 3 * verticalMargin
  property real horizontalMargin: dp(Theme.navigationBar.defaultBarItemPadding)
  property real verticalMargin: dp(Theme.navigationBar.defaultBarItemPadding)
  property real spacing: dp(10)

  default property alias content: contentColumn.children
  property alias title: titleSection.text

  // width will be set via binding in Component.onCompleted
  height: calculatedHeight

  color: Theme.backgroundColor

  AppText {
    id: titleSection
    anchors {
      top: parent.top
      topMargin: root.verticalMargin
      horizontalCenter: parent.horizontalCenter
    }

    font {
      bold: true
      pixelSize: sp(16)
    }
  }

  Column {
    id: contentColumn

    anchors {
      horizontalCenter: parent.horizontalCenter
      top: titleSection.bottom
      topMargin: root.verticalMargin
    }

    width: parent.width - 2 * horizontalMargin

    spacing: root.spacing

    onHeightChanged: {
      if (!root.parent.columns) {
        internal.adjustColorAndHeight()
      }
    }
  }

  Item {
    anchors.top: contentColumn.bottom
    height: root.verticalMargin
    width: parent.width
  }

  QtObject {
    id: internal

    function resetHeight() {
      root.height = root.calculatedHeight
      root.height = Qt.binding(function() { return root.calculatedHeight})
    }

    function adjustColorAndHeight() {
      for (var i = 0; i < root.parent.children.length; i++) {
        if (root.parent.children[i] === root) {

          if (root.parent.columns > 1) {
            if (i % 2 == 1) {
              var left = root.parent.children[i - 1]
              var right  = root.parent.children[i]

              left.height = Qt.binding(function() {return (right.calculatedHeight > left.calculatedHeight) ? right.calculatedHeight : left.calculatedHeight})
              right.height = Qt.binding(function() {return (right.calculatedHeight > left.calculatedHeight) ? right.calculatedHeight : left.calculatedHeight})
            }

            if (i % 4 >= 2) {
              root.color = "#f8f9fa"
            } else {
              root.color = Theme.backgroundColor
            }
          } else {
            if (i % 2 == 1) {
              root.color = "#f8f9fa"
            } else {
              root.color = Theme.backgroundColor
            }

            resetHeight()
          }
        }
      }
    }
  }

  onWidthChanged: {
    internal.adjustColorAndHeight()
  }

  Component.onCompleted: {
    internal.adjustColorAndHeight()
    width = Qt.binding(function() { return app.tablet ? parent.width / 2 : parent.width })
  }
}
