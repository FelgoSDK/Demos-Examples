import QtQuick 2.0
import Felgo 4.0


App {
  id: app
  NavigationStack {
    AppPage {
      title: "InputDialog"

      AppButton {
        id: confirmBtn
        flat: false
        text: "InputDialog Confirm?"
        anchors.centerIn: parent
        onClicked: {
          InputDialog.confirm(app, "Confirm this action?", function(ok) {
            if (ok) {
              confirmBtn.text = "Confirmed!"
            }
          })
        }
      }
    }
  }
}
