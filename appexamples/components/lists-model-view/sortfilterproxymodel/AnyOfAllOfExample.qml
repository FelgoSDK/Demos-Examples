import Felgo 3.0
import QtQuick 2.0


App {
  id: app

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

  // List model for JSON data
  JsonListModel {
    id: jsonModel
    source: jsonData
    keyField: "id"
    fields: ["id", "title", "type"]
  }

  SortFilterProxyModel {
    id: sortedModel
    Component.onCompleted: {
      sourceModel = jsonModel
    }

    property var evenFilter: ExpressionFilter {
      // Expression to check for even numbers, e.g.: 2, 4, 6, ...
      expression: model.id % 2 === 0
    }

    property var fruitFilter: ExpressionFilter {
      // Expression to check for the item of a type "Fruit"
      expression: model.type === "Fruit"
    }

    property var allOfFilters: AllOf {
      // NOTE: Set a value to default property of FilterContainer ancestor e.g. AnyOf/AllOf
      filters: [ sortedModel.evenFilter, sortedModel.fruitFilter ]
    }

    property var anyOfFilters: AnyOf {
      filters: [ sortedModel.evenFilter, sortedModel.fruitFilter ]
    }
  }

  Navigation {
    navigationMode: navigationModeTabsAndDrawer
    NavigationItem {
      title: "Source model"
      icon: IconType.home

      NavigationStack {
        ListPage {
          title: "Source model"
          model: jsonData
          delegate: SimpleRow {
            text: modelData.id + " " + modelData.title + " " + modelData.type
          }
        }
      }
    }

    NavigationItem {
      title: "AnyOf"
      icon: IconType.filter
      onSelected: sortedModel.filters = [ sortedModel.anyOfFilters ]

      NavigationStack {
        ListPage {
          title: "AnyOf"
          listView.header: AppText {
            padding: dp(10)
            wrapMode: Text.WordWrap
            width: parent.width
            text: 'Request to filter <b>AnyOf("id is even", "type=Fruit")</b>. We read this as "id is even" OR "type=Fruit". '
                  + 'Thereby we got a list containing fruits "apple" and "banana", and even number 2 for ham:'
          }
          model: sortedModel
          delegate: SimpleRow {
            text: model.id + " " + model.title + " " + model.type
          }
        }
      }
    }

    NavigationItem {
      title: "AllOf"
      icon: IconType.filter
      onSelected: sortedModel.filters = [ sortedModel.allOfFilters ]

      NavigationStack {
        ListPage {
          title: "AllOf"
          listView.header: AppText {
            padding: dp(10)
            wrapMode: Text.WordWrap
            width: parent.width
            text: 'Request to filter <b>AllOf("id is even", "type=Fruit")</b>. We read this as "id is even" AND "type=Fruit". '
                  + 'Thereby we got a list with only 1 element, because only for this item both conditions are true: '
          }
          model: sortedModel
          delegate: SimpleRow {
            text: model.id + " " + model.title + " " + model.type
          }
        }
      }
    }
  }
}
