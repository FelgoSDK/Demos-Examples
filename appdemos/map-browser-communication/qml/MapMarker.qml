import QtLocation 5.14
import Felgo 3.0

MapQuickItem {
  visible: false
  property alias icon: iconItem.icon
  property alias color: iconItem.color
  anchorPoint {
    x: sourceItem.width / 2
    y: sourceItem.height
  }

  sourceItem: Icon {
    id: iconItem
    icon: IconType.mapmarker
    size: dp(30)
  }
}