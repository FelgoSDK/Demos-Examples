import QtQuick
import Felgo

App {
  id: app

  property bool onDevice: false
  property string localeId: "en-US"

  Connections {
    target: SpeechToText

    onSpeechToTextResult: (result, isFinal) => {
      appTextEdit.text = result
    }

    onSpeechToTextError: error => {
      console.warn("Error:", error)
    }
  }

  NavigationStack {
    AppPage {
      title: qsTr("Speech To Text")

      Column {
        spacing: dp(20)

        width: parent.width - dp(40)
        anchors.centerIn: parent

        AppText {
          text: qsTr("Available: %1").arg(SpeechToText.recognitionAvailable)
        }

        AppText {
          text: qsTr("OnDevice available: %1").arg(SpeechToText.onDeviceRecognitionAvailable)
        }

        AppText {
          text: qsTr("Active: %1").arg(SpeechToText.recognitionActive)
        }

        AppText {
          text: qsTr("Locale: %1").arg(app.localeId)
        }

        Row {
          spacing: dp(20)

          AppText {
            id: onDeviceSwitch
            text: qsTr("On Device")
          }

          AppSwitch {
            anchors.verticalCenter: onDeviceSwitch.verticalCenter
            onCheckedChanged: {
              app.onDevice = !app.onDevice
            }
          }
        }

        Flow {
          spacing: dp(20)
          width: parent.width

          AppButton {
            text: qsTr("Start")

            onClicked: {
              appTextEdit.reset()
              SpeechToText.startSpeechToText(app.localeId, app.onDevice)
            }
          }

          AppButton {
            text: qsTr("Stop")

            onClicked: {
              SpeechToText.stopSpeechToText()
            }
          }

          AppButton {
            text: qsTr("Cancel")

            onClicked: {
              appTextEdit.reset()
              SpeechToText.cancelSpeechToText()
            }
          }
        }

        AppTextEdit {
          id: appTextEdit

          width: parent.width
          enabled: false

          function reset() {
            appTextEdit.text = ""
          }
        }
      }
    }
  }
}
