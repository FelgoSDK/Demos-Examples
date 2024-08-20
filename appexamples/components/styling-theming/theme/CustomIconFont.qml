import Felgo 4.0
import QtQuick 2.5


App {

  readonly property string gitHubLogo: "\uF127"
  readonly property string gitLabLogo: "\uF128"
  readonly property string gMailLogo: "\uF129"
  readonly property string stackOverflowLogo: "\uF159"

  onInitTheme: {
    Theme.iconFont = iconFont
  }

  FontLoader {
    id: iconFont
    source: "https://cdnjs.cloudflare.com/ajax/libs/css-social-buttons/1.4.0/css/zocial.ttf"

    onStatusChanged: {
      if (status === FontLoader.Ready) {
        Theme.iconFont = iconFont
      }
    }
  }

  AppPage {
    AppText {
      id: text
      text: "Try to use custom icon font:"
      anchors.centerIn: parent
      font.pixelSize: px(36)
    }

    Row {
      anchors {
        top: text.bottom
        topMargin: dp(10)
        horizontalCenter: text.horizontalCenter
      }
      spacing: dp(8)

      AppIcon {
        size: dp(36)
        iconType: gitHubLogo
      }

      AppIcon {
        size: dp(36)
        iconType: gitLabLogo
      }

      AppIcon {
        size: dp(36)
        iconType: gMailLogo
      }

      AppIcon {
        size: dp(36)
        iconType: stackOverflowLogo
      }
    }
  }
}
