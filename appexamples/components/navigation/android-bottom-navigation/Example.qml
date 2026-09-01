import QtQuick
import Felgo

App {
  Navigation {
    // Use tabs on Android, else default (which is tabs on iOS and drawer on desktop)
    navigationMode: Theme.isAndroid ? navigationModeTabs : navigationModeDefault
    // On Android, only the selected label is shown by default. You can change that by accessing the internal tabs or using the theming
    //tabs.showOnlySelectedLabel: false // can also be changed with Theme.navigationTabBar.showOnlySelectedLabel

    NavigationItem {
      title: "First"
      iconType: IconType.heart

      NavigationStack {
        AppPage {
          title: "First Page"
        }
      }
    }

    NavigationItem {
      title: "Second"
      iconType: IconType.book

      NavigationStack {
        AppPage {
          title: "Second Page"
        }
      }
    }

    NavigationItem {
      title: "Third"
      iconType: IconType.bolt

      NavigationStack {
        AppPage {
          title: "Third Page"
        }
      }
    }
  }
}
