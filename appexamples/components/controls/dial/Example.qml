import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    Page {
      id: page
      title: "Dial"

      Column {
        id: column
        spacing: dp(16)
        anchors.centerIn: parent

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Math.round(dial.value * 100) + "%"
          font.bold: true
        }

        QC2.Dial {
          id: dial
          height: dp(200)
          width: dp(200)
        }
      }
    }
  }
}
