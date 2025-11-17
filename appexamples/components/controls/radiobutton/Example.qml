import Felgo
import QtQuick
import QtQuick.Controls as QC2


App {
  NavigationStack {
    AppPage {
      id: page
      title: "RadioButton"

      Column {
        id: column
        spacing: dp(20)
        anchors.centerIn: parent

        QC2.RadioButton {
          text: "First"
        }

        QC2.RadioButton {
          text: "Second"
        }

        QC2.RadioButton {
          text: "Third"
        }

        QC2.RadioButton {
          text: "Disabled"
          enabled: false
        }
      }

      QC2.ButtonGroup {
        id: group
        buttons: column.children
        onClicked: {
          console.log("Radio button clicked: " + button.text)
        }
      }
    }
  }
}
