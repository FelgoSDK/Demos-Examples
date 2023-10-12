import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls 1.4

Navigation {
  id: appNav
  navigationMode: navigationModeTabs
  anchors.fill: parent

  NavigationItem {
    title: qsTr("Home")
    icon: IconType.home

    NavigationStack {
      id: navStack1
      CategoryPage {category: "general"}
    }
  }

  NavigationItem {
    title: qsTr("Sports")
    icon: IconType.soccerballo

    NavigationStack {
      id: navStack2
      CategoryPage {category: "sports"}
    }
  }

  NavigationItem {
    title: qsTr("Entertainment")
    icon: IconType.film

    NavigationStack {
      id: navStack3
      CategoryPage {category: "entertainment"}
    }
  }

  NavigationItem {
    title: qsTr("More")
    icon: IconType.ellipsish

    NavigationStack {
      id: navStack4
      MorePage {}
    }
  }
}

