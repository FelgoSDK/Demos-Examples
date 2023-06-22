import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "Grid"

      // Let's setup a grid with 2 rows and 4 columns
      Grid {
        columns: 4
        rows: 2

        spacing: dp(16)
        anchors.centerIn: parent

        AppText {
          text: "Flags"
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

        AppText {
          text: "Drinks"
        }

        AppIcon {
          iconType: IconType.beer
        }

        AppIcon {
          iconType: IconType.coffee
        }

        AppIcon {
          iconType: IconType.glass
        }
      }
    }
  }
}
