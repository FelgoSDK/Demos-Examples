import Felgo 4.0
import QtQuick 2.0


App {

  function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
  }

  NavigationStack {
    AppPage {
      id: page
      title: "SearchBar"

      SearchBar {
        id: searchBar
        target: listView
        pullEnabled: true
        onAccepted: {
          console.log("Search accepted: " + text)
          // If the search bar is not empty, we prevent it from disappearing
          if (text === "") {
            searchBar.keepVisible = false
            filter.enabled = false
          } else {
            searchBar.keepVisible = true
            filter.pattern = text
            filter.enabled = true
          }
        }
      }

      ListModel {
        id: model
        Component.onCompleted: {
          for (var i = 0; i < 100; i++) {
            // Construct interesting name e.g. "Model Item #13: 4242"
            model.append( { "name": "Model Item #" + i + ": " + getRandomInt(9999) } )
          }
        }
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
      }

      AppListView {
        id: listView
        height: parent.height - y // Search bar modifies the y-position of the list
        model: filteredModel
        delegate: SimpleRow {
          text: name
        }
      }
    }
  }
}
