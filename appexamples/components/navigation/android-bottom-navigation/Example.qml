import QtQuick 2.3
import Felgo 3.0

App {
  Navigation {
    // Use tabs on Android, else default (which is tabs on iOS and drawer on desktop)
    navigationMode: Theme.isAndroid ? navigationModeTabs : navigationModeDefault
    // On Android, only the selected label is shown by default. You can change that by accessing the internal tabs or using the theming
    //tabs.showOnlySelectedLabel: false // can also be changed with Theme.navigationTabBar.showOnlySelectedLabel

    NavigationItem {
      title: "First"
      icon: IconType.heart

      NavigationStack {
        Page {
          title: "First Page"
        }
      }
    }

    NavigationItem {
      title: "Second"
      icon: IconType.book

      NavigationStack {
        Page {
          title: "Second Page"
        }
      }
    }

    NavigationItem {
      title: "Third"
      icon: IconType.bolt

      NavigationStack {
        Page {
          title: "Third Page"
        }
      }
    }
  }
}
