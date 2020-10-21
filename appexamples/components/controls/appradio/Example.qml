import QtQuick 2.8
import QtQuick.Controls 2.3 as QC2
import Felgo 3.0

App {
  NavigationStack {
    Page {
      title: "AppRadio"
      backgroundColor: Theme.secondaryBackgroundColor

      Column {
        width: parent.width

        SimpleSection {
          title: "As list items: " + ratioButtonGroup1.checkedButton.value + " selected"
        }

        QC2.ButtonGroup {
          id: ratioButtonGroup1
          buttons: [radio1, radio2, radio3]
        }

        AppListItem {
          text: "First Option"
          showDisclosure: false

          leftItem: AppRadio {
            id: radio1
            checked: true
            value: "Option 1"
            anchors.verticalCenter: parent.verticalCenter
          }

          onSelected: {
            if(!radio1.checked) radio1.toggle()
          }
        }

        AppListItem {
          text: "Second Option"
          showDisclosure: false

          leftItem: AppRadio {
            id: radio2
            value: "Option 2"
            anchors.verticalCenter: parent.verticalCenter
          }

          onSelected: {
            if(!radio2.checked) radio2.toggle()
          }
        }

        AppListItem {
          text: "Third Option"
          showDisclosure: false
          lastInSection: true

          leftItem: AppRadio {
            id: radio3
            value: "Option 3"
            anchors.verticalCenter: parent.verticalCenter
          }

          onSelected: {
            if(!radio3.checked) radio3.toggle()
          }
        }

        SimpleSection {
          title: "Inline: " + ratioButtonGroup2.checkedButton.value + " selected"
        }

        QC2.ButtonGroup {
          id: ratioButtonGroup2
          buttons: [radio4, radio5]
        }

        Rectangle {
          width: parent.width
          height: contentCol.height

          Column {
            id: contentCol
            width: parent.width
            padding: dp(Theme.contentPadding)

            AppRadio {
              id: radio4
              value: "Option 1"
              text: "First Option"
              checked: true
            }

            AppRadio {
              id: radio5
              value: "Option 2"
              text: "Second Option"
            }
          }
        }
      }
    }
  }
}
