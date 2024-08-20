import Felgo 4.0
import QtQuick 2.0
import "components"
import "model"
import "logic"
import "pages"


App {
  color: "#000"

  onInitTheme: {
    Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite

    // Colors customization
    Theme.colors.backgroundColor = "#121212"
    Theme.colors.secondaryBackgroundColor = Theme.colors.backgroundColor
    Theme.colors.tintColor = "#1ed35e"
    Theme.colors.secondaryTextColor = "#b3b3b3"
    Theme.colors.textColor = "white"

    // tabBar customization
    Theme.navigationTabBar.backgroundColor = "#282828"
    Theme.navigationTabBar.titleOffColor = "#afafaf"
    Theme.navigationTabBar.titleColor = "#f5f5f5"
    Theme.navigationTabBar.height = 50
    Theme.navigationTabBar.dividerColor = "transparent"

    // navigationBar customization
    Theme.navigationBar.backgroundColor = "#282828"
    Theme.navigationBar.titleColor = "white"
    Theme.navigationBar.itemColor = "white"
    Theme.navigationBar.titleAlignLeft = false
    Theme.navigationBar.dividerColor = Theme.navigationBar.backgroundColor
  }

  Storage {
    id: storage
  }

  Logic {
    id: logic
  }

  DataModel {
    id: dataModel
  }

  SoundManager {
    id: soundManager
  }

  // view
  Navigation {
    id: navigation
    navigationMode: navigationModeTabs

    NavigationItem {
      id: homePageItem
      title: qsTr("Home")
      iconType: IconType.home

      NavigationStack {
        initialPage: HomePage { }
      }
    }

    NavigationItem {
      id: searchPageItem
      title: qsTr("Search")
      iconType: IconType.search

      NavigationStack {
        id: searchNavigationStack

        initialPage: SearchTermsPage {
          onSearchRequested: searchNavigationStack.push(searchPageComponent, {"searchTerm": term})
        }
      }
    }

    NavigationItem {
      id: libraryPageItem
      title: qsTr("Library")
      iconType: IconType.list

      NavigationStack {
        initialPage: LibraryPage { }
      }
    }
  }

  Component {
    id: searchPageComponent
    SearchPage { }
  }

  Component {
    id: previewPageComponent
    PreviewPage { }
  }

  Component {
    id: settingsPageComponent
    SettingsPage { }
  }

  ActuallyPlayingOverlay {
    id: actuallyPlayingOverlay

    anchors.bottom: parent.bottom
    anchors.bottomMargin: dp(Theme.navigationTabBar.height) + nativeUtils.safeAreaInsets.bottom
  }



  ActuallyPlayingModal {
    id: actuallyPlayingModal
  }
}
