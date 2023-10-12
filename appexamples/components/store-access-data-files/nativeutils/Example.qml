import Felgo 3.0
import QtQuick 2.0


App {
  property string userName: ""
  NavigationStack {
    Page {
      title: "nativeUtils"

      Column {
        anchors.horizontalCenter: parent.horizontalCenter

        AppButton {
          text: "Open Felgo Website"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            nativeUtils.openUrl("https://felgo.com")
          }
        }

        AppButton {
          text: "Display MessageBox"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            // Show an Ok and Cancel button, and no additional text
            nativeUtils.displayMessageBox(qsTr("Do you agree?"), "", 2)
          }
        }

        AppText {
          id: userAcceptLabel
          anchors.horizontalCenter: parent.horizontalCenter
        }

        AppButton {
          text: "Display TextInput dialog"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            // Input text will be pre-filled with the current userName value
            nativeUtils.displayTextInput("Enter your name:", "", "", userName)
          }
        }

        AppText {
          id: userNameLabel
          anchors.horizontalCenter: parent.horizontalCenter
          text: userName !== "" ? "User name: " + userName : ""
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Vibrate"
          // Visible only on iOS or Android
          visible: nativeUtils.deviceModel() !== "unknown"
          onClicked: {
            nativeUtils.vibrate()
          }
        }

        AppText {
          // Visible only on iOS or Android
          visible: nativeUtils.deviceModel() !== "unknown"
          width: dp(250)
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Information about device:\n"
                + "manufacturer " + nativeUtils.deviceManufacturer() + "\n"
                + "model " + nativeUtils.deviceModel()

        }
      }
    }
  }

  // Result of the messageBox is received with a connection to the signal messageBoxFinished
  Connections {
    target: nativeUtils
    // This signal has the parameter accepted, telling if the Ok button was clicked
    onMessageBoxFinished: {
      console.debug("User confirmed the Ok/Cancel dialog with:", accepted)
      if (accepted) {
        userAcceptLabel.text = "Accepted"
      } else {
        userAcceptLabel.text = "Declined"
      }
    }
  }

  // Result of the input dialog is received with a connection to the signal textInputFinished
  Connections {
    target: nativeUtils
    // This signal has the parameters accepted and enteredText
    onTextInputFinished: {
      // If the input was confirmed with Ok, store the userName as the property
      if (accepted) {
        userName = enteredText;
        console.log("Entered user name:", userName);
      }
    }
  }
}

