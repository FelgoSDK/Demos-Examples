import QtQuick 2.1
import QtQuick.Controls 2.1
import Felgo 3.0


App {
  id: app

  property string workerResult: "Result not available yet"
  property bool workerInProgress: false
  property alias substractYears: yearsTumbler.currentIndex
  property alias substractMonths: monthsTumbler.currentIndex
  property alias substractDays: daysTumbler.currentIndex
  readonly property string currentDateString: convertDateToString(new Date)

  function convertDateToString(date) {
    return Qt.formatDate(new Date(date), "yyyy-M-d")
  }

  WorkerScript {
    id: myWorker
    source: "assets/workerscript.js"

    onMessage: (messageObject) => {
                 // Get and process answer from worker script
                 if (messageObject.result && messageObject.result.error && messageObject.result.error !== "") {
                   console.warn("Error happened: ", messageObject.result.error)
                   app.workerResult = messageObject.result.error
                 } else {
                   app.workerResult = JSON.parse(messageObject.result).difference
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
      title: "WorkerScript"

      Column {
        anchors {
          centerIn: parent
        }
        spacing: dp(10)

        Row {
          spacing: dp(10)
          AppText {
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            text: "From date:"
          }

          AppTextField {
            id: dateField
            width: dp(100)
            text: app.currentDateString
            enabled: !app.workerInProgress

            // Disable manual editing of this field and fires an event when the user clicks on it
            clickEnabled: true
            readOnly: true

            onClicked: {
              // Display a native date picker on each platform. Result is returned as a slot of nativeUtils
              nativeUtils.displayDatePicker()
            }

            Connections {
              target: nativeUtils
              onDatePickerFinished: (accepted, date) => {
                                      if (accepted) {
                                        dateField.text = convertDateToString(date)
                                      }
                                    }
            }
          }
        }

        AppText {
          font.bold: true
          text: "Substract:"
        }

        Row {
          spacing: dp(3)
          enabled: !app.workerInProgress

          Tumbler {
            id: yearsTumbler
            anchors.verticalCenter: parent.verticalCenter
            model: 50
            visibleItemCount: 3
          }
          AppText {
            anchors.verticalCenter: parent.verticalCenter
            text: "years"
          }
          Tumbler {
            id: monthsTumbler
            anchors.verticalCenter: parent.verticalCenter
            model: 12
            visibleItemCount: 3
          }
          AppText {
            anchors.verticalCenter: parent.verticalCenter
            text: "months"
          }
          Tumbler {
            id: daysTumbler
            anchors.verticalCenter: parent.verticalCenter
            model: 31
            visibleItemCount: 3
          }
          AppText {
            anchors.verticalCenter: parent.verticalCenter
            text: "days"
          }
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Ask Worker"
          flat: false
          onClicked: {
            myWorker.sendMessage( {
                                   baseDate: dateField.text,
                                   years: app.substractYears,
                                   months: app.substractMonths,
                                   days: app.substractDays
                                 } )
            workerInProgress = true
          }
          enabled: !workerInProgress
        }

        AppText {
          id: workerResult
          anchors.horizontalCenter: parent.horizontalCenter
          text: app.workerResult
        }
      }
    }
  }
}
