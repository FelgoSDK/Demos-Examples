import Felgo 3.0


App {
  Navigation {
    NavigationItem {
      title: "Navigation"
      icon: IconType.calculator

      NavigationStack {
        Page {
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
      icon: IconType.list

      NavigationStack {
        Page {
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
      icon: IconType.square

      NavigationStack {
        Page {
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
      icon: IconType.cogs

      NavigationStack {
        Page {
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

