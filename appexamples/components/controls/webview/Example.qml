import Felgo 4.0
import QtWebView 1.1


App {
  NavigationStack {
    AppPage {
      id: page
      title: "WebView"

      WebView {
        anchors.fill: parent
        url: "https://www.google.com"
      }
    }
  }
}
