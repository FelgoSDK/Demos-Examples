import Felgo 3.0
import QtQuick 2.0

import "native_controls"

App {
  NavigationStack {
    Page {
      title: "Native WebView example"

      DynamicNativeWebView {
        anchors.fill: parent
        url: "https://felgo.com"
      }
    }
  }
}
