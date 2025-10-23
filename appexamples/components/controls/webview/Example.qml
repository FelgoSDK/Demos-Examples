import Felgo
import QtWebView


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
