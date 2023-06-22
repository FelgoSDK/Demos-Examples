import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "JsonListModel"

      property var jsonData: [
        {
          "id": 1,
          "title": "Apple",
          "type": "Fruit"
        },
        {
          "id": 2,
          "title": "Ham",
          "type": "Meat"
        },
        {
          "id": 3,
          "title": "Bacon",
          "type": "Meat"
        },
        {
          "id": 4,
          "title": "Banana",
          "type": "Fruit"
        }
      ]

      // List model for json data
      JsonListModel {
        id: jsonModel
        source: page.jsonData
        keyField: "id"
        fields: ["id", "title", "type"]
      }

      // SortFilterProxyModel for sorting or filtering lists
      SortFilterProxyModel {
        id: sortedModel
        // Note: when using JsonListModel, the sorters or filter might not be applied correctly when directly assigning
        // sourceModel use the Component.onCompleted handler instead to initialize SortFilterProxyModel
        Component.onCompleted: {
          sourceModel = jsonModel
        }
        sorters: StringSorter {
          id: typeSorter
          roleName: "type"
          ascendingOrder: true
        }
      }

      AppListView {
        anchors.fill: parent
        model: sortedModel
        delegate: SimpleRow {
          text: model.title
        }
        section {
          property: "type"
          delegate: SimpleSection { }
        }
      }

      // Button to change the sorting order
      AppButton {
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
          bottomMargin: nativeUtils.safeAreaInsets.bottom
        }

        text: "Change Order"
        onClicked: {
          typeSorter.ascendingOrder = !typeSorter.ascendingOrder
        }
      }
    }
  }
}
