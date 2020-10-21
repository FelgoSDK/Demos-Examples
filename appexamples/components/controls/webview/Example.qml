import Felgo 3.0
import QtWebView 1.1


App {
  NavigationStack {
    Page {
      id: page
      title: "WebView"

      WebView {
        anchors.fill: parent
        url: "https://www.google.com"
      }
    }
  }
}
