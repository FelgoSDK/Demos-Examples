import QtQuick 2.12

Item {

  // property to configure target logic
  property alias dispatcher: logicConnection.target

  // property to configure target dataModel
  property alias model: modelConnection.target

  // property to hold current page of app, this is useful to track where the user triggered an action
  property var currentPage

  // property to disable logging for logic actions
  property alias logicLogging: logicConnection.enabled

  // property to disable logging for model signals
  property alias modelLogging: modelConnection.enabled

  // listen dispatcher signals (to log user actions)
  Connections {
    id: logicConnection

    // actions
    onFetchTodos: console.log(currentPage.title + " Action - fetchTodos")
    onFetchTodoDetails: console.log(currentPage.title + " Action - fetchTodoDetails: id="+id)
    onFetchDraftTodos: console.log(currentPage.title + " Action - fetchDraftTodos")
    onCreateDraftTodo: console.log(currentPage.title + " Action - createDraftTodo: todo="+JSON.stringify(todo))
    onStoreDraftTodo: console.log(currentPage.title + " Action - storeDraftTodo: todo="+JSON.stringify(todo))
    onClearCache: console.log(currentPage.title + " Action - clearCache")
    onIncrementNumberOfPages: console.log(currentPage.title + " Action - IncrementNumberOfPages")
  }

  // listen to model signals (to log storage success / errors)
  Connections {
    id: modelConnection

    // action success signals
    onTodoStored: console.log("Success - todoStored: draftId= "+draftId+", todoId="+todoId)
    onDraftTodoCreated: console.log("Success - draftTodoCreated: todo="+JSON.stringify(todo))

    // action error signals
    onFetchTodosFailed: console.error("Error - fetchTodosFailed: error="+JSON.stringify(error))
    onFetchTodoDetailsFailed: console.error("Error - fetchTodoDetailsFailed: id="+id+", error="+JSON.stringify(error))
    onStoreDraftTodoFailed: console.error("Error - storeDraftTodoFailed: todo="+JSON.stringify(todo)+", error="+JSON.stringify(error))
  }
}
