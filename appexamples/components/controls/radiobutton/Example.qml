import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    Page {
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
