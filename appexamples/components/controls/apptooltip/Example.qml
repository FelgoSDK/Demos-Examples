import Felgo 4.0
import QtQuick 2.0

App {
  NavigationStack {
    AppPage {
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
