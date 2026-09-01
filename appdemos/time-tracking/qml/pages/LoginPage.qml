import Felgo
import QtQuick

AppPage {
  z: 100

  signal login()

  Column {
    anchors.centerIn: parent
    spacing: dp(15)
    width: dp(210)

    AppText {
      text: "Welcome!"
      font.pixelSize: sp(30)
      font.bold: true
    }

    AppText {
      text: "Sign in to your Jira Account:"
      color: Theme.secondaryTextColor
    }

    AppTextField {
      id: url
      width: parent.width
      inputMode: inputModeUrl

      text: "myjira.atlassian.net"
    }

    AppTextField {
      id: email
      width: parent.width
      inputMode: inputModeEmail

      text: "johndoe@example.com"
    }

    AppTextField {
      id: pwd
      width: parent.width
      inputMode: inputModePassword

      text: "password"
    }

    AppButton {
      text: "Sign In"

      flat: false
      anchors.horizontalCenter: parent.horizontalCenter
      minimumWidth: parent.width
      enabled: url.length > 0 && email.length > 0 && pwd.length > 0
      onClicked: {
        login()
      }
    }
  }
}
