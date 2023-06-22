import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "Row"

      // Items are laid side by side
      Row {
        // Lay items with a bit more space
        spacing: dp(16)
        anchors.centerIn: parent

        AppText {
          text: "Fun with Rows "
        }

        AppIcon {
          iconType: IconType.flag
        }

        AppIcon {
          iconType: IconType.flagcheckered
        }

        AppIcon {
          iconType: IconType.flago
        }
      }
    }
  }
}
