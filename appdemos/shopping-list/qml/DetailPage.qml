import QtQuick 2.5
import QtQuick.Controls 2.3
import Felgo 4.0

// This page shows the details of a single shopping items.
// It allows the user to edit the shopping item text.
AppPage {
  id: detailPage

  title: qsTr("Edit Shopping Item")

  // The property contains all the information about the current shopping item.
  // It is set by the App when this page gets pushed to the navigation stack.
  property var shoppingItem

  // The signal is emitted if the user wants to store a modified shopping
  // item text and clicked on the 'save' button.
  signal saveShoppingItem(var shoppingItem)

  // The save item is included in the app bar and is therefore always
  // in the right location, both for Android and iOS.
  // Tapping the button emits the saveShoppingItem singal to inform the
  // data model to send the changes to the Google Firebase Realtime Database.
  rightBarItem: IconButtonBarItem {
    iconType: IconType.save
    onClicked: {
      // Unfocus the text box to make the on-screen keyboard disappear.
      textEditShoppingItem.focus = false
      // Get the new text from the UI control and assign it to the shopping item.
      shoppingItem.text = textEditShoppingItem.text
      // Emit the signal to store the changes in the shopping item.
      detailPage.saveShoppingItem(shoppingItem)
    }
  }

  // Text area that allows the user to edit the text of the shopping item.
  TextArea {
    id: textEditShoppingItem

    // Various layout settings
    width: parent.width
    padding: dp(12)
    verticalAlignment: TextEdit.AlignTop
    font.pixelSize: sp(14)

    // Qt's TextEdit has some problems with predictive text on Android
    // when using non-default keyboards (like SwiftKey)
    // problem also exists for TextArea
    inputMethodHints: Qt.ImhNoPredictiveText

    placeholderText: qsTr("Shopping item text")
  }

  Component.onCompleted: {
    // When the page has been loaded, get the shopping item text from the
    // property (was assigned by the App item) and put the text into the
    // text area.
    console.log(JSON.stringify(shoppingItem))
    textEditShoppingItem.text = shoppingItem.text

    // Start editing when this page opens
    textEditShoppingItem.forceActiveFocus()
    textEditShoppingItem.cursorPosition = shoppingItem.text.length
  }
}
