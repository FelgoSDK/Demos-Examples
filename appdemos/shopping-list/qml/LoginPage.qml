import Felgo 3.0
import QtQuick 2.5

// The login page is kept simple to focus on the main functionality.
// It contains two text fields to enter the user name and password.
// Additionally, the user can decide via a check box whether to
// register a new user or to log in with an existing user.
Page {
  id: loginPage
  title: qsTr("Login")

  // The login signal is emitted when the user tapped on the button.
  // Depending on the state of the checkbox, the boolean is set to
  // true (register a new user) or false (login with an existing user)
  signal login(bool isRegister, string email, string password)

  Column {
    anchors.fill: parent
    anchors.margins: dp(12)
    spacing: dp(12)

    // Email text field
    AppTextField {
      id: textFieldEmail
      width: parent.width

      // Use a pre-defined user to make testing easier
      text: system.publishBuild ? "" : "testuser124@v-play.net"

      placeholderText: qsTr("E-mail address")
      inputMethodHints: Qt.ImhEmailCharactersOnly
    }

    // Password text field
    AppTextField {
      id: textFieldPassword
      width: parent.width

      // Use a pre-defined password to make testing easier
      text: system.publishBuild ? "" : "testuserpw"

      placeholderText: qsTr("Password")
      echoMode: TextInput.Password
    }

    // Check box to switch between mode to register a new user or to log in.
    AppCheckBox {
      id: checkBoxRegister
      text: qsTr("Register new user")
      checked: false
    }

    AppButton {
      text: checkBoxRegister.checked ? qsTr("Register") : qsTr("Login")

      // Button clicked -> emit signal to perform login / registration.
      onClicked: loginPage.login(checkBoxRegister.checked, textFieldEmail.text, textFieldPassword.text)
    }
  }
}
