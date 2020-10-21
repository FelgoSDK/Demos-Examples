import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
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

        Icon {
          icon: IconType.flag
        }

        Icon {
          icon: IconType.flagcheckered
        }

        Icon {
          icon: IconType.flago
        }
      }
    }
  }
}
