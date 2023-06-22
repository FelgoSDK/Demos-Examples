import Felgo 4.0
import QtQuick 2.12
import "../ui"

AppPage {
  id: page

  title: viewHelper.formatTodoId(todoData)
  rightBarItem: NavigationBarRow {
    // network activity indicator
    ActivityIndicatorBarItem {
      id: activityBarItem
      visible: dataModel.isBusy && !dataModel.isStoringTodos
      showItem: showItemAlways // do not collapse into sub-menu on Android
    }

    // navigation bar button to save new todo if draft
    IconButtonBarItem {
      id: saveBarItem
      iconType: IconType.save
      visible: isDraft
      showItem: showItemAlways
      onClicked: logic.storeDraftTodo(todoData)
    }
  }

  // target id
  property int todoId: 0

  // data property for page
  property var todoData: dataModel.todoDetails[todoId]

  // whether it is a draft
  readonly property bool isDraft: dataModel.isDraft(todoData)

  // load data initially or when id changes
  onTodoIdChanged: {
    logic.fetchTodoDetails(todoId)
  }

  // handle data model signals for storing drafts
  Connections {
    target: dataModel
    enabled: isDraft

    // update to new id and data when draft is stored
    onTodoStored: (draftId, todoId) => {
      if(page.todoId === draftId)
        page.todoId = todoId
    }

    // show message box if storing failed
    onStoreDraftTodoFailed: {
      if(page.todoId === todo.id)
        nativeUtils.displayMessageBox(qsTr("Failed to store ")+viewHelper.formatTodoId(todo))
    }
  }

  // content area
  TodoDetailContent { }

  // busy indicator with overlay when todo is being saved
  Rectangle {
    visible: dataModel.isStoringTodos
    anchors.fill: parent
    color: Qt.rgba(1, 1, 1, 0.2)

    AppActivityIndicator {
      anchors.centerIn: parent
    }
  }
}
