import Felgo 3.0
import QtWebView 1.1


App {
  id: app

  Navigation {
    id: navigation
    navigationMode: navigationModeDrawer

    NavigationItem {
      title: "Web View"
      icon: IconType.globe

      NavigationStack {

        Page {
          id: page
          title: "Web View"

          WebView {
            anchors.fill: parent
            url: "https://www.google.com"
            // Visible only if the drawer is NOT open
            visible: !navigation.drawer.isOpen
          }
        }
      }
    }
  }
}
