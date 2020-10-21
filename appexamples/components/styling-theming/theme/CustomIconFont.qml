import Felgo 3.0
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

  Page {
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

      Icon {
        size: dp(36)
        icon: gitHubLogo
      }

      Icon {
        size: dp(36)
        icon: gitLabLogo
      }

      Icon {
        size: dp(36)
        icon: gMailLogo
      }

      Icon {
        size: dp(36)
        icon: stackOverflowLogo
      }
    }
  }
}
