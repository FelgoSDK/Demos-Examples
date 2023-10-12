import Felgo 3.0
import QtQuick 2.0

App {
  NavigationStack {
    Page {
      title: "ToolTip Page"

      AppButton {
        id: myButton
        text: "Open ToolTip"
        anchors.centerIn: parent
        onClicked: myToolTip.open()
      }

      AppToolTip {
        id: myToolTip
        target: myButton
        text: "This button opens a tool tip."
      }
    }
  }
}
