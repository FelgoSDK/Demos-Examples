import Felgo 3.0
import QtQuick 2.0

import "native_examples"

App {
  NavigationStack {
    Page {
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
