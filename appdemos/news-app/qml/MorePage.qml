import QtQuick
import Felgo


AppPage {
  id: more
  title: qsTr("More Topics")

  rightBarItem: IconButtonBarItem {
    iconType: IconType.gear
    onClicked: more.navigationStack.popAllExceptFirstAndPush(settingsPage)
  }

  SortFilterProxyModel {
    id: filteredModel
    Component.onCompleted: sourceModel = menuModel
    filters: [
      ValueFilter {
        roleName: "favorite"
        value: false
      }
    ]
  }

  AppListView {
    model: filteredModel
    delegate: AppListItem {
      onSelected: more.navigationStack.push(categoryPage, {category: name, navStack: navStack4})
      text: listText
    }
  }
}
