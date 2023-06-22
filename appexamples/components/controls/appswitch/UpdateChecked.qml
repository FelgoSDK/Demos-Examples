import QtQuick 2.0
import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "AppSwitch updateChecked"

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        Row {
          spacing: dp(20)

          AppText {
            id: simpleSwitchLabel
            text: "SimpleSwitch:"
            width: dp(200)
          }

          AppSwitch {
            id: simpleSwitch
            anchors.verticalCenter: simpleSwitchLabel.verticalCenter
            onCheckedChanged: {
              console.log("Checked new value: " + checked)
            }
          }
        }

        Row {
          spacing: dp(20)

          AppText {
            text: "SimpleSwitch.updateChecked:"
            width: dp(200)
          }

          AppCheckBox {
            anchors.verticalCenter: simpleSwitchLabel.verticalCenter
            onCheckedChanged: {
              simpleSwitch.updateChecked = !simpleSwitch.updateChecked
            }
          }
        }
      }
    }
  }
}
