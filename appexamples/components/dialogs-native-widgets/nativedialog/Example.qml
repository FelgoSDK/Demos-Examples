import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "NativeDialog"

      Column {
        spacing: dp(Theme.contentPadding)
        anchors.centerIn: parent

        AppButton {
          id: confirmBtn
          text: "Confirm Dialog"
          onClicked: NativeDialog.confirm("Please Confirm", "Confirm this action?", function(ok) {
            if (ok) {
              confirmBtn.text = "Confirmed!"
            }
          })
        }

        AppButton {
          id: inputBtn
          text: "Input Dialog"
          onClicked: NativeDialog.inputText("Quick Question", "What do you think?", "Input here", "", function(ok, text) {
            if (ok) {
              inputBtn.text = "Input: " + text
            }
          })
        }
      }
    }
  }
}
