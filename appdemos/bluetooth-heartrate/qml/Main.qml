import Felgo 3.0
import QtQuick 2.13

import "./pages"
import "./model"

App {
  id: app

  onInitTheme: {
    Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite

    Theme.colors.tintColor = "#3EA6DE"
    Theme.colors.backgroundColor = "#3a3a3a"
    Theme.colors.secondaryBackgroundColor = "#303030"
    Theme.colors.textColor = "#FFFCF2"

    Theme.navigationBar.backgroundColor = Theme.colors.backgroundColor
    Theme.navigationBar.titleColor = Theme.colors.textColor
    Theme.navigationBar.dividerColor = Theme.navigationBar.backgroundColor

    Theme.listItem.backgroundColor = "#363636"
    Theme.listItem.selectedBackgroundColor = "#303030"
    Theme.listItem.detailTextColor = "#aaa"
    Theme.listItem.dividerHeight = 0
  }

  // App object models
  property ApplicationModel application: ApplicationModel { }

  property HeartModel heartRate: HeartModel {
    beating: bpm > 0 && application.connected
  }

  NavigationStack {
    id: navigationStack

    MonitorPage { }
  }
}
