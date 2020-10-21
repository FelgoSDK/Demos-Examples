import Felgo 3.0
import QtQuick 2.0

// Item for filter settings
Rectangle {
  width: parent.width
  height: childrenRect.height
  color: Theme.backgroundColor

  // properties
  property bool sortTitleActive: titleCheckBox.checked

  property bool filterCompletedActive: completedCheckBox.checked

  property bool storeDraftsActive: storeCheckbox.checked

  // ui column
  Column {
    id: filterSettings
    width: storeCheckbox.width
    anchors.horizontalCenter: parent.horizontalCenter

    AppCheckBox {
      id: titleCheckBox
      text: qsTr("Sort by Title")
      labelFontSize: sp(12)
      height: dp(36)
    }

    AppCheckBox {
      id: completedCheckBox
      text: qsTr("Filter Completed")
      labelFontSize: sp(12)
      height: dp(36)
    }

    AppCheckBox {
      id: storeCheckbox
      text: qsTr("Store New Drafts")
      labelFontSize: sp(12)
      height: dp(36)
      checked: true
    }
  }
}
