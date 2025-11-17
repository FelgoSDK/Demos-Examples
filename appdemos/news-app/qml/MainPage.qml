import QtQuick
import Felgo

Navigation {
  id: appNav
  navigationMode: navigationModeTabs
  anchors.fill: parent

  NavigationItem {
    title: qsTr("Home")
    iconType: IconType.home

    NavigationStack {
      id: navStack1
      CategoryPage {category: "general"}
    }
  }

  NavigationItem {
    title: qsTr("Sports")
    iconType: IconType.soccerballo

    NavigationStack {
      id: navStack2
      CategoryPage {category: "sports"}
    }
  }

  NavigationItem {
    title: qsTr("Entertainment")
    iconType: IconType.film

    NavigationStack {
      id: navStack3
      CategoryPage {category: "entertainment"}
    }
  }

  NavigationItem {
    title: qsTr("More")
    iconType: IconType.ellipsish

    NavigationStack {
      id: navStack4
      MorePage {}
    }
  }
}

