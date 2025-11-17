import Felgo
import QtQuick

import "native_controls"

App {
  NavigationStack {
    AppPage {
      title: "Native Button example"

      DynamicNativeButton {
        text: "Native Button"

        width: dp(240)
        height: dp(48)

        anchors.centerIn: parent

        onClicked: text = "Clicked"
      }
    }
  }
}
