import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "AppTextField"

      Column {
        width: dp(200)
        spacing: dp(16)
        anchors.centerIn: parent

        AppTextField {
          width: parent.width
          // Display a small border around the text field
          borderWidth: dp(1)
          placeholderText: "What's your name?"
          inputMode: inputModeUsername
        }

        AppTextField {
          width: parent.width
          placeholderText: "How old are you?"
          borderWidth: dp(1)

          // Displays a number only keyboard on mobiles
          inputMethodHints: Qt.ImhDigitsOnly

          // Only accept positive numbers
          validator: IntValidator {
            bottom: 1
            top: 100
          }
        }

        AppTextField {
          width: parent.width
          placeholderText: "Enter an email address"
          borderWidth: dp(1)
          // Only characters suitable for email addresses are allowed
          inputMode: inputModeEmail
        }

        AppTextField {
          width: parent.width
          placeholderText: "Enter a password"
          borderWidth: dp(1)
          inputMode: inputModePassword
        }
      }
    }
  }
}
