import Felgo
import QtQuick


App {

  function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max))
  }

  NavigationStack {

    AppPage {
      id: page
      title: "Add/Remove Items to/from JsonListModel"

      property var jsonData: [
        { "id": 1, "text": "Random number " + getRandomInt(9999) },
        { "id": 2, "text": "Random number " + getRandomInt(9999) },
        { "id": 3, "text": "Random number " + getRandomInt(9999) }
      ]

      JsonListModel {
        id: jsonModel
        source: page.jsonData
        keyField: "id"
      }

      Row {
        id: buttonsRow
        anchors {
          top: parent.top
          left: parent.left
          right: parent.right
        }
        height: dp(50)

        // Button to add an item
        AppButton {
          // Counter to use and increase in case if we add new item
          property int currentItemNumber: 4

          text: "Add Item with id=" + currentItemNumber
          onClicked: {
            // Create and add new item
            const newItem = { "id" : currentItemNumber, text: "Random number " + getRandomInt(9999) }
            jsonModel.append(newItem)
            currentItemNumber++
          }
        }

        // Button to remove an item
        AppButton {
          text: "Remove Second Row"
          onClicked: {
            // Remove second item from the data model
            jsonModel.remove(1, 1)
          }
        }
      }

      AppListView {
        id: listView
        anchors {
          top: buttonsRow.bottom
          bottom: parent.bottom
        }
        width: parent.width
        bottomMargin: nativeUtils.safeAreaInsets.bottom

        model: jsonModel
        delegate: AppListItem {
          text: "Item id: " + model.id
          detailText: model.text
        }
      }
    }
  }
}
