import QtQuick 2.0
import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "AppSwitch"

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        Row {
          spacing: dp(20)

          AppText {
            id: simpleSwitchLabel
            text: "Simple AppSwitch:"
            width: dp(200)
          }

          AppSwitch {
            anchors.verticalCenter: simpleSwitchLabel.verticalCenter
            onCheckedChanged: {
              console.log("Checked new value: " + checked)
              disabledSwitch.checked = checked
            }
          }
        }

        Row {
          spacing: dp(20)

          AppText {
            id: label
            width: dp(200)
            text: "Disabled AppSwitch without shadow:"
          }

          AppSwitch {
            id: disabledSwitch
            anchors.verticalCenter: label.verticalCenter

            dropShadow: false
            enabled: false
          }
        }
      }
    }
  }
}
