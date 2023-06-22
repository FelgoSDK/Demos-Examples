import QtLocation 5.14
import Felgo 4.0

MapQuickItem {
  visible: false
  property alias iconType: iconItem.iconType
  property alias color: iconItem.color
  anchorPoint {
    x: sourceItem.width / 2
    y: sourceItem.height
  }

  sourceItem: AppIcon {
    id: iconItem
    iconType: IconType.mapmarker
    size: dp(30)
  }
}
