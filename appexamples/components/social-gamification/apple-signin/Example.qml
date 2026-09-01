import QtQuick
import Felgo

App {
  NavigationStack {
    AppPage {
      title: "Apple Sign In"

      Column {
        anchors.centerIn: parent
        spacing: dp(15)

        AppleSignInButton {
          id: appleSignInButton
          anchors.horizontalCenter: parent.horizontalCenter
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: appleSignInButton.appleSignIn.isSignedIn
                ? "Signed in: " + appleSignInButton.appleSignIn.userName
                :  appleSignInButton.appleSignIn.isAvailable
                ? "Click above to sign in with Apple user"
                : "Apple Sign-in unavailable."
        }
      }
    }
  }
}
