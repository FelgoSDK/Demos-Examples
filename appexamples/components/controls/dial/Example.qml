import Felgo
import QtQuick
import QtQuick.Controls as QC2


App {
  NavigationStack {
    AppPage {
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
