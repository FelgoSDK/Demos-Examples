import QtQuick 2.1
import Felgo 3.0

App {
  id: app

  property bool workerInProgress: false
  property int result: -1

  WorkerScript {
    id: myWorker
    source: "assets/simpleworkerscript.js"

    onMessage: (messageObject) => {
                 // Get and process answer from worker script
                 if (messageObject.result) {
                   result = messageObject.result
                 }
                 workerInProgress = false
               }
  }

  NavigationStack {
    Page {
      rightBarItem: ActivityIndicatorBarItem {
        id: activityIndicator
        visible: workerInProgress
      }
      title: "Simple WorkerScript"

      Column {
        anchors {
          centerIn: parent
        }
        spacing: dp(10)

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Input a number (N):"
        }

        AppTextField {
          id: inputNumber
          anchors.horizontalCenter: parent.horizontalCenter
          placeholderText: "Input a number"
          inputMethodHints: Qt.ImhDigitsOnly
          maximumLength: 4
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Calculate N*N"
          flat: false
          onClicked: {
            if (inputNumber.text.length > 0) {
              let n = parseInt(inputNumber.text)
              myWorker.sendMessage( { number: n } )
              workerInProgress = true
            }
          }
          enabled: !workerInProgress
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Result: " + ((result != -1) ? result : "not available yet")
        }
      }
    }
  }
}
