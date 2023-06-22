import Felgo 4.0


App {
  Navigation {

    // Navigation item is displayed natively on each platform (as a tab or inside drawer menu)
    NavigationItem {
      title: "First Page"
      iconType: IconType.calculator

      NavigationStack {
        AppPage {
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
      iconType: IconType.list

      NavigationStack {
        AppPage {
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
