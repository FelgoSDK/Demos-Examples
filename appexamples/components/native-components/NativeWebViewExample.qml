import Felgo
import QtQuick

import "native_controls"

App {
  NavigationStack {
    AppPage {
      title: "Native WebView example"

      DynamicNativeWebView {
        anchors.fill: parent
        url: "https://felgo.com"
      }
    }
  }
}
