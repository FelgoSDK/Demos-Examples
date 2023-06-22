import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "AppTextEdit"

      // Remove focus from textEdit if background is clicked
      MouseArea {
        anchors.fill: parent
        onClicked: {
          textEdit.focus = false
        }
      }

      // Background for input
      Rectangle {
        anchors {
          fill: textEdit
          margins: -dp(8)
        }
        color: "lightgrey"
      }

      AppTextEdit {
        id: textEdit
        width: dp(200)

        // As you type the height will grow to accommodate more text
        height: contentHeight

        placeholderText: "Type multiline text..."
        anchors.centerIn: parent

        // We want the text wrap around words
        wrapMode: AppTextEdit.WordWrap
      }
    }
  }
}
