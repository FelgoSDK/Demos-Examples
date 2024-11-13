import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "App Lifecycle"

      AppTextEdit {
        id: textEdit
        anchors.centerIn: parent
        width: parent.width * 0.9
        height: parent.height * 0.8
        text: "We'll log events of paused/resumed app."
      }
    }
  }
  onApplicationPaused: textEdit.text = textEdit.text + "\nApplication paused."
  onApplicationResumed: textEdit.text = textEdit.text + "\nApplication resumed."
}
