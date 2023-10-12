import Felgo 3.0
import QtQuick 2.5

// The master page is based on the master-detail-template of Felgo.
// In this app, it shows a list of shopping items.
// It lets the user add new items, delete items or tap on them to
// navigate to the DetailPage.
ListPage {
  id: masterPage
  // The page title
  title: qsTr("Shopping Items")

  // Model of the list shown on the page. These are the keys
  // from the data stored in the data model. When the scrollable
  // list view needs to render an item, the delegate requests the
  // full details of the shopping item from the data model.
  model: Object.keys(dataModel.shoppingItems)

  // Signal is emitted whenever the user added a new shopping item.
  // The parameter contains the name (text) of the new shopping item.
  signal addNewShoppingItem(string text)
  // Delete a shopping item.
  // The item is referenced through the numeric ID.
  signal deleteShoppingItem(real id)
  // The user tapped on a shopping item in the list and would like
  // to navigate to the details page.
  signal showShoppingItemDetails(var shoppingItem)

  // Button for adding a new shopping item.
  // This is shown in the application bar, automatically consistent
  // with the style guide of the target platform (Android / iOS)
  rightBarItem: IconButtonBarItem {
    // Use one of the pre-defined icons, in this case the 'plus' icon.
    icon: IconType.plus

    onClicked: {
      // When the user tapped on the 'plus' icon, show a simple text
      // input dialog. The user can enter single-line text.
      InputDialog.inputTextSingleLine(app,
                                      "What to add to the list?", // message text
                                      "Input here",               // placeholder text
                                      function(ok, text) {
                                        if(ok) {
                                          // If the user tapped on OK, emit the
                                          // signal to add a new shopping item to
                                          // the data model.
                                          masterPage.addNewShoppingItem(text)
                                        }
                                      })
    }
  }

  // The delegate is responsible for drawing a single item in the scrollable
  // list box. Additionall, it contains the swipe-able delete button that is revealed when
  // the user swipes an item to the left
  delegate: SwipeOptionsContainer {
    id: container

    // This property allows access to the complete data of the shopping item
    // that is displayed by the delegate. It accesses the data through
    // the datamodel, based on the key.
    // modelData == key of shopping item in data model
    readonly property var shoppingItem: dataModel.shoppingItems[modelData] || {}

    // Delete button that is revealed on the right side
    // when swiping the shopping item to the left.
    rightOption: SwipeButton {
      anchors.fill: parent

      // Make the item red and with a remove 'X' symbol.
      backgroundColor: "red"
      icon: IconType.remove

      onClicked: {
        // Delete button has been tapped for this item.
        // First, hide the delete button again.
        container.hideOptions()
        // Date is also the unique ID. Emit the signal so that
        // the data model deletes the item from the Google Firebase Realtime Database.
        masterPage.deleteShoppingItem(container.shoppingItem.date)
      }
    }

    // The SimpleRow is a pre-defined control that uses a commonly-needed standard
    // layout for a list item. In this case, we use the main and detail text to
    // show the shopping item.
    SimpleRow {
      width: parent.width

      // The main text contains the shopping item name text
      text: container.shoppingItem.text || ""
      // The detail text (shown below the main text) shows the date
      // when the item has been added to the shopping list.
      detailText: new Date(container.shoppingItem.date).toLocaleString() || ""

      // Format the detail text so that it doesn't consume more than one line
      detailTextItem {
        maximumLineCount: 1
        elide: Text.ElideRight
      }

      onSelected: {
        // Whenever a shopping item is tapped, emit the signal to navigate
        // to the DetailPage.
        console.log(JSON.stringify(modelData))
        masterPage.showShoppingItemDetails(container.shoppingItem)
      }

    }
  }
}
