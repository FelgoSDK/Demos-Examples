import Felgo
import QtQuick

// UI Item for todo details
Item {
  anchors.fill: parent

  // show / hide items using state
  state: !!todoData || dataModel.isBusy ? "default" : "nodata"

  // state definition
  states: [
    State {
      name: "nodata"
      PropertyChanges { target: contentList; visible: false }
      PropertyChanges { target: noDataMessage; visible: true }
    },
    State {
      name: "default"
      PropertyChanges { target: contentList; visible: true }
      PropertyChanges { target: noDataMessage; visible: false }
    }
  ]

  AppListView {
    id: contentList
    anchors.fill: parent
    enabled: parent.visible
    model: !!todoData ? Object.keys(todoData) : undefined

    // here we display each property - value pair
    delegate: SimpleRow {
      property string propName: modelData
      property string value: todoData[propName]

      // this list should not be interactive
      enabled: false
      active: false

      // capitalize the first letter of the main title
      textItem.font.capitalization: Font.Capitalize

      text: propName
      detailText: value
    }
  }

  // show message if data not available
  AppText {
    id: noDataMessage
    anchors.verticalCenter: parent.verticalCenter
    text: qsTr("Todo data not available. Please check your internet connection.")
    width: parent.width
    horizontalAlignment: Qt.AlignHCenter
  }
}
