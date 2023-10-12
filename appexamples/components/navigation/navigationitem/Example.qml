import Felgo 3.0


App {
  Navigation {

    // Navigation item is displayed natively on each platform (as a tab or inside drawer menu)
    NavigationItem {
      title: "First Page"
      icon: IconType.calculator

      NavigationStack {
        Page {
          title: "First Page"
          AppText {
            anchors.centerIn: parent
            text: "First Page"
          }
        }
      }
    }

    NavigationItem {
      title: "Second Page"
      icon: IconType.list

      NavigationStack {
        Page {
          title: "Second Page"

          AppText {
            anchors.centerIn: parent
            text: "Second Page"
          }
        }
      }
    }
  }
}
