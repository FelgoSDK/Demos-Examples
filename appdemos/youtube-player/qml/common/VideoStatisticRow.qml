import Felgo 4.0
import QtQuick 2.0

Row {
  property alias iconItem: icon
  property alias textItem: text

  AppIcon {
    id: icon
    iconType: IconType.eye
    color: Theme.secondaryTextColor
    size: dp(12)
  }

  AppText {
    id: text
    text: "12345"
    color: Theme.secondaryTextColor
    font.pixelSize: dp(12)
  }
}
