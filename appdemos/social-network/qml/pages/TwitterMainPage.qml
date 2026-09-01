import QtQuick

import Felgo
import "."
import "../widgets"


AppPage {
  id: twitterMainPage

  // These can be used from anywhere in the app - this way the QML files are parsed only once
  Component { id: mainPageComponent; MainPage { } }
  Component { id: detailPageComponent; DetailPage { } }
  Component { id: profilePageComponent; ProfilePage { } }
  Component { id: listsPageComponent; ListsPage { } }

  // make page navigation public, so app-demo launcher can track navigation changes and log screens with Google Analytics
  property alias navigation: navigation

  useSafeArea: false // fill full screen

  Navigation {
    id: navigation
    drawer.drawerPosition: drawer.drawerPositionLeft
    headerView: NavHeader {}
    footerView: NavFooter {}

    navigationDrawerItem: AppIcon {
      iconType: Theme.isAndroid ? "menu" : IconType.navicon
      textItem.font.family: Theme.isAndroid ? Theme.androidIconFont.name : Theme.iconFont.name
      size: Theme.isAndroid ? dp(Theme.navigationBar.androidIconSize) : dp(Theme.navigationBar.defaultIconSize)
      anchors.centerIn: parent
      color: navigation.currentIndex == 3 ? "black" : Theme.navigationBar.itemColor
    }

    //this overrides the default mode of drawer on android and tabs elsewhere
    //navigationMode: navigationModeTabsAndDrawer

    NavigationItem {
      title: "Home"
      iconType: IconType.home

      NavigationStack {
        MainPage { }
      }
    }

    NavigationItem {
      title: "Lists"
      iconType: IconType.bars

      NavigationStack {
        ListsPage { }
      }
    }

    NavigationItem {
      title: "Messages"
      iconType: IconType.envelope

      NavigationStack {
        MessagesPage { }
      }
    }

    NavigationItem {
      title: "Me"
      iconType: IconType.user

      NavigationStack {

        // manually push profilePage to fix initial scroll position of profile page
        // (due to bug when using ListView::headerItem)
        Component.onCompleted: {
          push(profilePageComponent, { profile: dataModel.currentProfile })
        }
      }
    }
  }
}
