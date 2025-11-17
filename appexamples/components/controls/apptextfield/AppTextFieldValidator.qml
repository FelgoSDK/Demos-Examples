import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
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
          // Do not use predictive text while typing
          inputMethodHints: Qt.ImhNoPredictiveText
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
          placeholderText: "Try to enter email address"
          borderWidth: dp(1)
          // Only characters suitable for email addresses are allowed
          inputMethodHints: Qt.ImhEmailCharactersOnly
        }

        AppTextField {
          width: parent.width
          placeholderText: "Field for password"
          borderWidth: dp(1)
          echoMode: TextInput.Password
        }
      }
    }
  }
}
