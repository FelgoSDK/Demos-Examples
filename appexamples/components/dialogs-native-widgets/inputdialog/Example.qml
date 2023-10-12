import Felgo 3.0


App {
  id: app

  NavigationStack {
    Page {
      title: "InputDialog"

      AppButton {
        id: appButton
        anchors.centerIn: parent
        text: "Input Dialog"

        onClicked: InputDialog.inputTextSingleLine(app,
          "What do you think?", //message text
          "Input here", //placeholder text
          function(ok, text) {
            if(ok) {
              appButton.text = "Input: " + text
            }
          }
        )
      }
    }
  }
}
