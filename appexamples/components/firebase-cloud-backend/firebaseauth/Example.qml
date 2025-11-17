import QtQuick
import Felgo


App {
  licenseKey: ""

  FirebaseAuth {
    id: auth

    config: FirebaseConfig {
      id: fbConfig
      // Get this value from the Firebase console
      projectId: "plugindemo-5fdd9"
      // Platform dependent - get these values from the google-services.json / GoogleService-info.plist
      apiKey: Qt.platform.os === "android"
              ? "AIzaSyD2gYC4s21kOJLwvuNUKizaB4ZR7Ma3rHg"
              : "AIzaSyDeCTZXfMbDT_nE6eHxvxVVHKO82wvYico"
      applicationId: Qt.platform.os === "android"
                     ? "1:944930955116:android:f4bdedd28961caf0"
                     : "1:944930955116:ios:f4bdedd28961caf0"
    }

    onLoggedIn: {
      nativeUtils.displayMessageBox("Logged in", "Login successful: " + (success ? "Yes." : "No: " + message))
    }

    onUserRegistered: {
      nativeUtils.displayMessageBox("Registered", "Registration successful: " + (success ? "Yes." : "No: " + message))
    }
  }

  NavigationStack {
    AppPage {
      title: "Firebase Auth"

      Column {
        anchors {
          fill: parent
          margins: dp(12)
        }
        spacing: dp(12)

        AppText {
          text: "Logged in: " + (auth.authenticated
                                 ? "Yes, e-mail: " + (auth.authenticatedAnonymously
                                                      ? "(anonymous)"
                                                      : auth.email)
                                 : "No")
        }

        AppTextField {
          id: emailInput
          placeholderText: "E-mail address"
        }

        AppTextField {
          id: pwInput
          placeholderText: "Password"
          echoMode: TextInput.Password
        }

        AppButton {
          text: "Log in with email and password"
          // Can only log in when not authenticated already
          enabled: !auth.authenticated
          onClicked: {
            auth.loginUser(emailInput.text, pwInput.text)
          }
        }

        AppButton {
          text: "Register with email and password"
          // Can register when either not authenticated or authenticated anonymously
          enabled: !auth.authenticated || auth.authenticatedAnonymously
          onClicked: {
            auth.registerUser(emailInput.text, pwInput.text)
          }
        }

        AppButton {
          text: "Log in anonymously"
          // Can only log in when not authenticated already
          enabled: !auth.authenticated
          onClicked: {
            auth.loginUserAnonymously()
          }
        }

        AppButton {
          text: "Log out"
          // Can only log out when not authenticated already
          enabled: auth.authenticated
          onClicked: {
            auth.logoutUser()
          }
        }
      }
    }
  }
}
