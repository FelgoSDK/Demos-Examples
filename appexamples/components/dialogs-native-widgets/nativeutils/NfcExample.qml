import Felgo 4.0
import QtQuick 2.0

App {
  NavigationStack {
    AppPage {
      title: "NFC Example"

      Column {
        anchors.centerIn: parent

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "NFC Device Support: %1".arg(nativeUtils.isNfcAvailable())
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "NFC Session Active: %1".arg(nativeUtils.nfcSessionActive)
        }

        Row {
          spacing: dp(5)

          AppButton {
            text: "Open Session"
            onClicked: nativeUtils.startNfcNdefSession("Hold near NDEF NFC Tag")
          }

          AppButton {
            text: "Close Session"
            onClicked: {
              result.reset()
              nativeUtils.stopNfcNdefSession()
            }
          }
        }


        AppText {
          id: result
          anchors.horizontalCenter: parent.horizontalCenter

          function showResult(text) {
            result.color = "black"
            result.text = text
          }

          function showError(text) {
            result.color = "red"
            result.text = text
          }

          function reset() {
            result.text = ""
          }
        }
      }
    }
  }

  Connections {
    target: nativeUtils

    onNfcNdefPayloadDetected: {
      nativeUtils.vibrate()

      console.debug("Received NDEF message:", payload, "from tag:", tagId)
      result.showResult("Tag: %1\nPayload: %2".arg(tagId).arg(payload))
    }

    onNfcNdefError: {
      console.debug("Error while reading NDEF message:", reason)
      result.showError(reason)
    }
  }
}
