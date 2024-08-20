import Felgo 4.0
import QtQuick 2.0

import "native_examples"

App {
  NavigationStack {
    AppPage {
      title: "Native Message example"

      NativeMessage {
        id: nativeMessage
      }
        
      AppButton {
        anchors.centerIn: parent

        text: "Show native message"
        onClicked: nativeMessage.showMessage("Native Message from QML")
      }
    }
  }
}
