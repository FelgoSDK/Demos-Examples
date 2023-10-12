import Felgo 3.0
import QtQuick 2.0


App {
  id: app

  property var myModel: [
    { label: "Item 1", info: "Some more info" },
    { label: "Item 2", info: "Some more info" },
    { label: "Item 3", info: "Some more info" },
    { label: "Item 4", info: "Some more info" },
    { label: "Item 5", info: "Some more info" },
  ]

  NavigationStack {
    Page {
      title: "AppListView"

      AppListView {
        model: app.myModel

        delegate: AppListItem {
          text: modelData.label
          detailText: modelData.info
        }
      }
    }
  }
}
