import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    id: navigationStack
    Page {
      title: "displayTextInput"
      AppButton {
        anchors.centerIn: parent
        text: "Open text input"
        onClicked: {
          nativeUtils.displayTextInput("Type some text, please",
                                       "We'd like to hear few words",
                                       "Write text here",
                                       "", "Ok", "Cancel")
        }
      }

      Connections {
        target: nativeUtils
        // Here we get notified of the text input finished
        onTextInputFinished: { // accepted, string enteredText
          if (accepted) {
            nativeUtils.displayAlertDialog("Nice text you've entered!", enteredText)
          }
        }
      }
    }
  }
}
