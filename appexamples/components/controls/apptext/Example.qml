import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "AppText"

      Column {
        anchors.centerIn: parent
        spacing: dp(20)

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "This is simple text"
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "This is bigger text"
          fontSize: sp(20)
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "This is bold colored text"
          font.bold: true
          color: "goldenrod"
        }
      }
    }
  }
}
