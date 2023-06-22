import Felgo 4.0
import QtQuick 2.0

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
