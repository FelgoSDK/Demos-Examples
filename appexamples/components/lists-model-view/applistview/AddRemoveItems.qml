import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {

    Page {
      id: page
      title: "Add List Items"

      // Data model for the list
      property var dataModel: [
        { text: "Item 1" },
        { text: "Item 2" },
        { text: "Item 3" }
      ]

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
          // Counter to use and increas in case if we add new item
          property int currentItemNumber: 3

          text: "Add Item " + (currentItemNumber + 1)
          onClicked: {
            // Create and add new item
            currentItemNumber++
            const newItem = { text: "Item " + currentItemNumber }
            page.dataModel.push(newItem)

            // Signal change in data model to trigger UI update (list view)
            page.dataModelChanged()
          }
        }

        // Button to remove an item
        AppButton {
          text: "Remove Second Row"
          onClicked: {
            // Remove second item from the data model
            page.dataModel.splice(1, 1)

            // Signal change in data model to trigger UI update (list view)
            page.dataModelChanged()
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

        model: page.dataModel
        delegate: AppListItem {
          text: modelData.text
        }
      }
    }
  }
}