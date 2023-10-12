import QtQuick 2.0
import Felgo 3.0
import "pages"
import "common"

App {
  id: app
  licenseKey: AppSettings.licenseKey

  property color secondaryTintColor: "#09102b"

  property string ratingUrl: system.isPlatform(System.IOS) ? "itms-apps://itunes.apple.com/at/app/id1484310915?mt=8" :
                             system.isPlatform(System.Android) ? "https://play.google.com/store/apps/details?id=net.vplay.demos.qtws2019" :
                             "https://felgo.com/qws-conference-in-app-2019"

  onInitTheme: {
    // default theme setup
    Theme.colors.tintColor = "#41cd52"
    Theme.navigationBar.backgroundColor = Qt.binding(function() { return Theme.isAndroid || Theme.isDesktop  ? app.secondaryTintColor : "#f8f8f8" })

    // tab bar
    Theme.tabBar.backgroundColor = Qt.binding(function() { return Theme.isAndroid || Theme.isDesktop ? app.secondaryTintColor : "#f8f8f8" })
    Theme.tabBar.markerColor = Qt.binding(function() { return Theme.tintColor })
    Theme.tabBar.titleColor = Qt.binding(function() { return Theme.tintColor })
    Theme.tabBar.titleOffColor = Qt.binding(function() { return Theme.secondaryTextColor })

    // status bar
    Theme.colors.statusBarStyle = Qt.binding(function() { return Theme.isAndroid || Theme.isDesktop ? Theme.colors.statusBarStyleWhite : Theme.colors.statusBarStyleBlack })
    Theme.dialog.buttonTextSize = 18
  }

  // handle Android back button (show dialog before closing application) // @disable-check M16
  onBackButtonPressedGlobally: {
    // only handle if on main page of app (back button jumps to main page otherwise)
    if(loaderItem.navigation && loaderItem.navigation.currentIndex !== 0)
      return

    // only handle if on first page of navigation stack (back button pops page otherwise)
    if(loaderItem.navigation && loaderItem.navigation.currentNavigationItem.navigationStack.depth !== 1)
      return

    // do not handle if navigation drawer is open (back button closes drawer in this case)
    if(loaderItem.navigation.drawer.isOpen)
      return

    // do nothing if window is already closed
    if(!app.visible)
      return

    // show confirmation dialog before quitting
    NativeDialog.confirm(qsTr("Really quit this app?"), "", function(ok) {
      if(ok)
        app.close()
    }, true)

    event.accepted = true // prevent immediate quit (back button default action)
  }

  // local notifications
  NotificationManager {
    id: notificationManager
  }

  // loads and holds actual app content
  QtWSLoaderItem { id: loaderItem }
}
