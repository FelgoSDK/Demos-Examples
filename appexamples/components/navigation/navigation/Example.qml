import Felgo 4.0


App {
  Navigation {
    NavigationItem {
      title: "Navigation"
      iconType: IconType.calculator

      NavigationStack {
        AppPage {
          title: "Navigation Switch"
          AppText {
            anchors.centerIn: parent
            text: "Navigation"
          }
        }
      }
    }

    NavigationItem {
      title: "List"
      iconType: IconType.list

      NavigationStack {
        AppPage {
          title: "List Page"

          AppText {
            anchors.centerIn: parent
            text: "List"
          }
        }
      }
    }

    NavigationItem {
      title: "Dialogs"
      iconType: IconType.square

      NavigationStack {
        AppPage {
          title: "Dialogs Page"

          AppText {
            anchors.centerIn: parent
            text: "Dialogs"
          }
        }
      }
    }

    NavigationItem {
      title: "Settings"
      iconType: IconType.cogs

      NavigationStack {
        AppPage {
          title: "Settings Page"

          AppText {
            anchors.centerIn: parent
            text: "Settings"
          }
        }
      }
    }
  }
}

