import Felgo
import QtQuick


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
    AppPage {
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
