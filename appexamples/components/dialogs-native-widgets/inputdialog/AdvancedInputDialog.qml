import Felgo
import QtQuick


App {
  id: app

  NavigationStack {
    AppPage {
      title: "InputDialog"

      Column {
        spacing: dp(Theme.contentPadding)
        anchors.centerIn: parent

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          id: appButton
          text: "Input Dialog"

          onClicked: {
            var dialog = InputDialog.inputTextSingleLine(app,
              "What do you think?", //message text
              "Input here", //placeholder text
              function (ok, text) {
                if(ok) {
                  result.text = "Input: " + text
                }
              }
            )

            // Disable the negative action
            dialog.negativeAction = false

            // Dismiss when touched outside
            dialog.outsideTouchable = true
          }
        }

        AppText {
          id: result
        }
      }
    }
  }
}
