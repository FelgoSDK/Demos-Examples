import QtQuick
import Felgo
import "pages"
import "common"
import "details"

App {
  id: app

  onInitTheme: {
    if(settings.getValue("qtwsDarkMode") !== undefined) {
      appDetails.darkMode = settings.getValue("qtwsDarkMode")
    }

    // default theme setup
    Theme.colors.statusBarStyle = Qt.binding(function() {return appDetails.darkMode ? Theme.colors.statusBarStyleWhite : Theme.colors.statusBarStyleBlack})
    Theme.colors.tintColor = eventDetails.neonColor
    Theme.colors.backgroundColor = Qt.binding(function() {return appDetails.darkMode ? eventDetails.pineColor : "#FFF"})
    Theme.colors.textColor = Qt.binding(function() {return appDetails.darkMode ? "#fbfbfb" : "#000"})
    Theme.colors.secondaryBackgroundColor = Qt.binding(function() {return appDetails.darkMode ? eventDetails.pineColor : "#E5E5E9"})
    Theme.colors.secondaryTextColor = Qt.binding(function() {return appDetails.darkMode ? "#cfcfcf" : "#5c5c5c"})
    Theme.colors.selectedBackgroundColor = Qt.binding(function() { return appDetails.darkMode ? Qt.lighter(Theme.backgroundColor, 2) : "#e5e5e9" })
    Theme.colors.dividerColor = "transparent"
    Theme.navigationBar.backgroundColor = Qt.binding(function() { return appDetails.darkMode ? eventDetails.pineColor : "#fff" })
    Theme.navigationBar.titleColor = eventDetails.neonColor
    Theme.navigationBar.dividerColor = Qt.binding(function() { return appDetails.darkMode ? "transparent" : "transparent" })
    Theme.navigationTabBar.backgroundColor = Qt.binding(function() { return appDetails.darkMode ? Qt.lighter(eventDetails.pineColor, 1.2) : "white" })
    Theme.navigationTabBar.titleOffColor = Qt.binding(function() { return appDetails.darkMode ? Qt.darker(eventDetails.neonColor, 1.7) : "#000" })
    Theme.navigationTabBar.titleColor = eventDetails.neonColor
    Theme.navigationTabBar.dividerColor = Qt.binding(function() { return appDetails.darkMode ? "transparent" : "transparent" }) //Qt.binding(function() { return Theme.navigationBar.dividerColor })
    Theme.navigationTabBar.height = dp(60)

    // tab bar
    Theme.tabBar.backgroundColor = Qt.binding(function() { return appDetails.darkMode ? eventDetails.pineColor : "#fff" })
    Theme.tabBar.markerColor = Qt.binding(function() { return Theme.tintColor })
    Theme.tabBar.subTabTitleColor = Qt.binding(function() { return Theme.isAndroid ? eventDetails.neonColor : eventDetails.pineColor })
    Theme.tabBar.titleOffColor = Qt.binding(function() { return Theme.secondaryTextColor })
    Theme.tabBar.dividerColor = "transparent"

    Theme.dialog.buttonTextSize = 18

    // list row
    Theme.listItem.backgroundColor = Qt.binding(function() {return appDetails.darkMode ? eventDetails.lightPineColor : "#FFF"})
    Theme.listItem.selectedBackgroundColor = Qt.binding(function() { return appDetails.darkMode ? Qt.lighter(Theme.listItem.backgroundColor, 1.2) : Qt.darker(Theme.listItem.backgroundColor, 1.05) })
    Theme.listItem.detailTextColor = Qt.binding(function() {return appDetails.darkMode ? eventDetails.neonColor : "#6C6C6C"})
    Theme.listItem.dividerColor = Qt.binding(function() {return appDetails.darkMode ? eventDetails.pineColor : Theme.dividerColor})

    Theme.listItem.dividerHeight = 1
    Theme.listSection.textColor = Qt.binding(function() { return Theme.isAndroid ? (appDetails.darkMode ? eventDetails.neonColor : Theme.textColor) : Theme.secondaryTextColor })
    Theme.listSection.backgroundColor = Qt.binding(function() { return Theme.secondaryBackgroundColor })
    Theme.listSection.textBottomMargin = 6
    Theme.listSection.totalHeight = Qt.binding(function() { return Theme.isIos ? 56 : 37 + 13 })
    Theme.listSectionCompact.textColor = Qt.binding(function() { return appDetails.darkMode ? Theme.textColor : Theme.secondaryTextColor })
    Theme.listSectionCompact.fontBold = false
    Theme.listSectionCompact.fontSize = 13
    Theme.colors.scrollbarColor = Qt.binding(function() { return appDetails.darkMode ? Qt.rgba(1,1,1,0.5) : Qt.rgba(0.7,0.7,0.7,0.7) })

    //app button
    Theme.appButton.borderColor = Qt.binding(function() { return appDetails.darkMode ? eventDetails.neonColor : eventDetails.pineColor })
    Theme.appButton.backgroundColor = Qt.binding(function() {
      if(Theme.isIos) {
        return "transparent"
      }
      else {
        return appDetails.darkMode ? eventDetails.neonColor : eventDetails.pineColor
      }
    })
    Theme.appButton.textColor = Qt.binding(function() {
      if(Theme.isIos) {
        return appDetails.darkMode ? eventDetails.neonColor : eventDetails.pineColor
      }
      else {
        return appDetails.darkMode ? eventDetails.pineColor : eventDetails.neonColor
      }
    })
    Theme.appButton.textColorPressed = Qt.binding(function() {
      if(Theme.isIos) {
        return appDetails.darkMode ? Qt.lighter(eventDetails.neonColor, 2) : eventDetails.neonColor
      }
      else {
        return appDetails.darkMode ? Qt.darker(eventDetails.pineColor, 2) : Qt.lighter(eventDetails.neonColor, 2)
      }
    })
    Theme.appButton.borderColorPressed = Qt.binding(function() {
      return Theme.appButton.textColorPressed
    })
  }

  // handle Android back button (show dialog before closing application)
  onBackButtonPressedGlobally: {
    // only handle if on main page of app (back button jumps to main page otherwise)
    if(loaderItem.navigation && loaderItem.navigation.currentIndex !== 0)
      return

    // only handle if on first page of navigation stack (back button pops page otherwise)
    if(loaderItem.navigation && loaderItem.navigation.currentNavigationItem.navigationStack.depth !== 1)
      return

    // show confirmation dialog before quitting
    NativeDialog.confirm(qsTr("Really quit this app?"),"",function(ok){
      if(ok)
        Qt.quit()
    }, true)

    event.accepted = true // prevent immediate quit (back button default action)
  }

  // local notifications
  NotificationManager {
    id: notificationManager
  }

  // loads and holds actual app content
  ContentLoaderItem { id: loaderItem }

  Connections {
    target: appDetails
    function onDarkModeChanged() {
      settings.setValue("qtwsDarkMode", appDetails.darkMode)
    }
  }

  // global items
  AppDetails { id: appDetails }
  EventDetails { id: eventDetails }
  PublisherDetails { id: publisherDetails }
  VenueDetails { id: venueDetails }
  Utils { id: utils }
}
