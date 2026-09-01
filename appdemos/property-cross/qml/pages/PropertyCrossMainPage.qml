import QtQuick

import Felgo

AppPage {
  readonly property real contentPadding: dp(Theme.navigationBar.defaultBarItemPadding) // use theme setting for padding, aligns content with navigation bar items

  // make page navigation-stack public, so app-demo launcher can track navigation changes and log screens with Google Analytics
  property alias childNavigationStack: navStack

  useSafeArea: false // fill whole screen

  NavigationStack {
    id: navStack
    leftColumnIndex: 1 //second page (listings list) is base for left column
    splitView: tablet

    SearchPage {
    }
  }
}
