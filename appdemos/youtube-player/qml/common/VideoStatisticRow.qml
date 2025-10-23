import Felgo
import QtQuick

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
