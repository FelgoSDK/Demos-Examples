import Felgo 4.0
import QtQuick 2.0
import "../ui"

AppPage {
  id: page
  title: qsTr("Todo List") // use qsTr for strings you want to translate

  leftBarItem: IconButtonBarItem {
    iconType: IconType.gear
    onClicked: settingsDialog.open()
  }

  rightBarItem: NavigationBarRow {
    // network activity indicator
    ActivityIndicatorBarItem {
      enabled: dataModel.isBusy
      visible: enabled
      showItem: showItemAlways
    }

    // add new todo
    IconButtonBarItem {
      iconType: IconType.plus
      showItem: showItemAlways
      onClicked: {
        // use qsTr for strings you want to translate
        var title = qsTr("New Todo")

        // this logic helper function adds a new draft
        logic.addNewDraftTodo(title)
      }
    }
  }

  // when draft is created, we open the draft and optionally store it
  Connections {
    target: dataModel
    onDraftTodoCreated: todo => {
      // open draft if split view is active (on tablets)
      if(page.navigationStack.splitViewActive)
        page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, { todoId: todo.id })

      // if activated, we store drafts whenever a draft is created
      if(sortFilterSettings.storeDraftsActive)
        logic.storeDraftTodo(todo)
    }
  }

  // JsonListModel
  // A ViewModel for JSON data that offers best integration and performance with list views
  JsonListModel {
    id: myJsonListModel
    source: dataModel.draftTodos.concat(dataModel.todos) // show both draft todos and stored todos
    keyField: "id"
    fields: ["id", "title", "completed"]
  }

  // SortFilterProxyModel
  // Proxy ViewModel for sorting or filtering ListModel data, also works with JsonListModel
  SortFilterProxyModel {
    id: filteredModel
    sourceModel: myJsonListModel

    // configure sorters
    sorters: [
      StringSorter {
        id: titleSorter
        roleName: "title"
        enabled: sortFilterSettings.sortTitleActive
      }]

    // configure filters
    filters: [
      ValueFilter {
        id: completedFilter
        roleName: "completed"
        value: true
        enabled: sortFilterSettings.filterCompletedActive
      }
    ]
  }

  // show sorted/filterd todos of data model
  AppListView {
    id: listView
    anchors.fill: parent

    // the model specifies the data for the list view
    model: filteredModel

    // the delegate is the template item for each entry of the list
    delegate: TodoListEntry {
        todoDraft: dataModel.isDraft(model)
        todoTitle: title
        todoComplete: completed
        todoId: id
    }

    // item animations, supported by list view for view model types like JsonListModel, ListModel or SortFilterProxyModel
    add: Transition {
      NumberAnimation {
        property: "opacity";
        from: 0;
        to: 1;
        duration: 200
        easing.type: Easing.OutQuad;
      }
    }

    addDisplaced: Transition {
      NumberAnimation {
        properties: "x,y";
        duration: 200
        easing.type: Easing.OutQuad;
      }
    }

    remove: Transition {
      NumberAnimation {
        property: "opacity";
        from: 1;
        to: 0;
        duration: 200
        easing.type: Easing.OutQuad;
      }
    }

    removeDisplaced: Transition {
      NumberAnimation {
        properties: "x,y";
        duration: 200
        easing.type: Easing.OutQuad;
      }
    }

    // hide scroll indicator, we automatically load more when bottom is reached
    scrollIndicatorVisible: false

    // load more todos
    footer: VisibilityRefreshHandler {
      canRefresh: !dataModel.isFetchingTodos && dataModel.fetchedPages <= dataModel.totalPages
      onRefresh: logic.fetchNextPage()
    }

    // fetch todos when pulling list view for refresh
    PullToRefreshHandler {
      refreshing: dataModel.isFetchingTodos
      onRefresh: logic.fetchTodos()
    }
  }

  // component for creating detail pages
  Component {
    id: detailPageComponent
    TodoDetailPage { }
  }


  // dialog for filter settings
  Dialog {
    id: settingsDialog
    title: qsTr("Settings")
    positiveAction: false
    negativeActionLabel: qsTr("Close")
    onCanceled: close()
    mainWindow: getApplication()

    SortFilterSettings {
      id: sortFilterSettings
      anchors.centerIn: parent
    }
  }
}
