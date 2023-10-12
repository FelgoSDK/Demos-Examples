import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "AppCheckBox"

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        AppCheckBox {
          id: firstCheckBox
          text: "1. " + (firstCheckBox.checked ? "Checked" : "Unchecked")
          checked: true
          onCheckedChanged: {
            console.log("First CheckBox changed to: " + checked)
          }
        }

        AppCheckBox {
          id: secondCheckBox
          text: "2. " + (secondCheckBox.checked ? "Checked" : "Unchecked")
          checked: false
          onCheckedChanged: {
            console.log("Second CheckBox changed to: " + checked)
          }
        }

        AppCheckBox {
          id: thirdCheckBox
          text: "3. Disabled unchecked"
          enabled: false
        }
      }
    }
  }
}
