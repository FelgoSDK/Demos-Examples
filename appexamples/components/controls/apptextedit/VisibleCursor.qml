import QtQuick 2.0
import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "AppTextEdit"

      rightBarItem: IconButtonBarItem {
        iconType: IconType.check
        onClicked: {
          // Remove focus from textEdit if background is clicked
          textEdit.focus = false
        }
      }

      backgroundColor: "beige"

      AppFlickable {
        id: appFlickable

        anchors {
          fill: parent
          margins: dp(20)
        }

        contentHeight: textEdit.height
        contentWidth: textEdit.width

        AppTextEdit {
          id: textEdit
          flickable: appFlickable
          // As you type the height will grow to accommodate more text
          height: contentHeight
          width: appFlickable.width

          placeholderText: "Type multiline text..."
          anchors.centerIn: parent

          cursorInView: true
          cursorInViewBottomPadding: keyboardHeight

          // We want the text wrap around words
          wrapMode: AppTextEdit.WordWrap
        }
      }

      AppScrollIndicator {
        flickable: appFlickable
      }
    }
  }
}
