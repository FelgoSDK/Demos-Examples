import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "SearchBar"

      SearchBar {
        id: searchBar
        onAccepted: {
          console.log("Search accepted: " + text)
          if (text === "") {
            filter.enabled = false
          } else {
            filter.pattern = text
            filter.enabled = true
          }
        }
      }

      ListModel {
        id: model
        ListElement { name: "Indian Prune" }
        ListElement { name: "Honeydew melon" }
        ListElement { name: "Prickly Pear" }
        ListElement { name: "Sugar Baby Watermelon" }
        ListElement { name: "Yunnan Hackberry" }
        ListElement { name: "Crab apples" }
        ListElement { name: "Queen Anne Cherry" }
      }

      // Sorted model for list view
      SortFilterProxyModel {
        id: filteredModel
        sourceModel: model
        // Add filter, so we could do filtering according to entered text
        filters: [
          RegExpFilter {
            id: filter
            roleName: "name"
            syntax: RegExpFilter.Wildcard
            caseSensitivity: Qt.CaseInsensitive
          }
        ]
        sorters: [
          StringSorter {
            roleName: "name"
            enabled: true
          }]
      }

      AppListView {
        id: listView
        anchors.top: searchBar.bottom
        model: filteredModel
        delegate: SimpleRow {
          text: name
        }
      }
    }
  }
}
