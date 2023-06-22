import QtQuick 2.4

import Felgo 4.0
import "../widgets"

ListPage {
  title: qsTr("Lists")

  listView.emptyText.text: qsTr("No lists")

  onItemSelected: (index, item) => {
    console.debug("Selected list at position", index)

    navigationStack.push(mainPageComponent, { title: item.text, rightBarItem: null })
  }

  // Note: No need to use JsonListModel, categories are hardcoded here and don't change
  model: [
    { "text": "Felgo Developers", "detailText": "49.213 members" },
    { "text": "App Developers", "detailText": "10.968 members" },
    { "text": "Random things", "detailText": "4.323 members" }
  ]
}
