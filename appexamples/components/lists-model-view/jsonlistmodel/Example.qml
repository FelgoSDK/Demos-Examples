import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "JsonListModel"
      id: page

      // Property with json data
      property var jsonData: [
        {
          "id": 1,
          "title": "Entry 1"
        },
        {
          "id": 2,
          "title": "Entry 2"
        },
        {
          "id": 3,
          "title": "Entry 3"
        }
      ]

      // List model for json data
      JsonListModel {
        id: jsonModel
        source: page.jsonData
        keyField: "id"
      }

      AppListView {
        anchors.fill: parent
        model: jsonModel
        delegate: SimpleRow {
          text: model.title
        }

        // Transition animation for adding items
        add: Transition {
          NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.OutQuad
          }
        }
      }

      // Button to add a new entry
      AppButton {
        anchors {
          margins: dp(16)
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
        }

        text: "Add Entry"
        onClicked: {
          var newItem = {
            "id": jsonModel.count + 1,
            "title": "Entry " + (jsonModel.count + 1)
          }
          page.jsonData.push(newItem)

          // Manually emit signal that jsonData property changed
          // JsonListModel thus synchronizes the list with the new jsonData
          page.jsonDataChanged()
        }
      }
    }
  }
}
