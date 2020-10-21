import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
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

        Icon {
          icon: IconType.flag
        }

        Icon {
          icon: IconType.flagcheckered
        }

        Icon {
          icon: IconType.flago
        }

        AppText {
          text: "Drinks"
        }

        Icon {
          icon: IconType.beer
        }

        Icon {
          icon: IconType.coffee
        }

        Icon {
          icon: IconType.glass
        }
      }
    }
  }
}
