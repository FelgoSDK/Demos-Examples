import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    Page {
      id: page
      title: "Tumbler"

      // Group tumbler sizing properties here
      property real tumblerSize: dp(20)
      property real tumblerWidth: tumblerSize * 3
      property real spacing: 0.5

      Column {
        anchors.centerIn: parent
        spacing: dp(32)

        AppText {
          // Compose the final string by binding to the tumbler currentIndex property
          property string currentHours: {
            if (hoursTumbler.currentIndex >= 0)
              return hoursTumbler.currentIndex
          }
          property string currentMinutes: {
            if (minutesTumbler.currentIndex >= 0)
              return minutesTumbler.currentIndex.toString().padStart(2, "0")
          }
          property string currentAmPm: {
            if (amPmTumbler.currentIndex >= 0)
              return amPmTumbler.model[amPmTumbler.currentIndex]
          }
          property string timeSet: currentHours + ":" + currentMinutes + " " + currentAmPm

          anchors.horizontalCenter: parent.horizontalCenter
          text: timeSet
          font {
            pixelSize: page.tumblerSize * 1.5
            bold: true
          }
        }

        Row {
          id: row
          anchors.horizontalCenter: parent.horizontalCenter

          QC2.Tumbler {
            id: hoursTumbler
            model: 12
            implicitHeight: page.tumblerSize * visibleItemCount * (1 + page.spacing)
            implicitWidth: page.tumblerWidth
          }

          QC2.Tumbler {
            id: minutesTumbler
            model: 60
            implicitHeight: page.tumblerSize * visibleItemCount * (1 + page.spacing)
            implicitWidth: page.tumblerWidth
          }

          QC2.Tumbler {
            id: amPmTumbler
            model: ["AM", "PM"]
            implicitHeight: page.tumblerSize * visibleItemCount * (1 + page.spacing)
            implicitWidth: page.tumblerWidth
          }
        }
      }
    }
  }
}
