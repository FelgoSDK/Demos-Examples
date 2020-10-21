import Felgo 3.0
import QtQuick 2.6

FlickablePage {
  id: root

  property bool allFieldsValid: nameField.isInputCorrect && emailField.isInputCorrect && passwordField.isInputCorrect && confirmPasswordField.isInputCorrect && termsOfServiceCheck.checked

  title: qsTr("Signup Example")
  flickable.contentHeight: content.height

  Column {
    id: content
    spacing: constants.defaultMargins
    topPadding: constants.defaultMargins
    bottomPadding: constants.defaultMargins
    anchors { left: parent.left; right: parent.right; margins: constants.defaultMargins }

    // we are not enforcing anything on its height. It will grow as necessary, and the page FlickablePage
    // will kick in making the content scrollable.

    ValidatedField {
      id: nameField
      label: qsTr("Name")
      placeholderText: qsTr("Enter your name")

      // we only allow names composed by letters and spaces
      validator: RegExpValidator {
        regExp: /[\w ]+/
      }

      // when the active focus is taken away from the textField we check if we need to display an error
      textField.onActiveFocusChanged: {
        hasError = !textField.activeFocus && !textField.acceptableInput
      }

      errorMessage: qsTr("Name not valid")
    }

    ValidatedField {
      id: emailField
      label: qsTr("Email")
      placeholderText: qsTr("Enter your email")

      // when the active focus is taken away from the textField we check if we need to display an error
      textField.onActiveFocusChanged: {
        hasError = !textField.activeFocus && !textField.acceptableInput
      }

      errorMessage: qsTr("The email address is not valid")

      // customize the text field to automatically discard invalid input and displays a "clear" text icon
      textField.inputMode: textField.inputModeEmail
    }

    ValidatedField {
      id: passwordField

      // we display an error message if the password length is less than 6
      property bool isPasswordTooShort: textField.text.length > 0 && textField.text.length < 6

      // this hides characters by default
      textField.inputMode: textField.inputModePassword
      label: qsTr("Password")
      placeholderText: qsTr("Type your password")

      hasError: isPasswordTooShort
      errorMessage: qsTr("Password is too short")
    }

    ValidatedField {
      id: confirmPasswordField

      property bool arePasswordsDifferent: passwordField.textField.text != confirmPasswordField.textField.text

      label: qsTr("Confirm password")
      placeholderText: qsTr("Confirm your password")
      textField.inputMode: textField.inputModePassword

      // we display an error message when the two password are different
      hasError: arePasswordsDifferent
      errorMessage: qsTr("Passwords do not match")
    }

    AppCheckBox {
      id: termsOfServiceCheck
      width: parent.width
      text: qsTr("I agree to terms of service")
    }

    AppText {
      text: qsTr("Read our <a href=\"https://felgo.com/doc/privacy-notes/\">privacy policy</a>")
      onLinkActivated: nativeUtils.openUrl(link)
    }

    // the submit button is only enabled if every field is valid and without error.
    AppButton {
      anchors.horizontalCenter: parent.horizontalCenter
      enabled: root.allFieldsValid
      text: qsTr("Submit")
      onClicked: {
        NativeDialog.confirm(qsTr("Success"), qsTr("Now you can proceed with login"), () => {
          navigation.navigateToProfilePage()
        })
      }
    }
  }
}
