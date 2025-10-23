import QtQuick

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
    function onFetchTodos() {
      console.log(currentPage.title + " Action - fetchTodos")
    }
    function onFetchTodoDetails(id) {
      console.log(currentPage.title + " Action - fetchTodoDetails: id="+id)
    }
    function onFetchDraftTodos() {
      console.log(currentPage.title + " Action - fetchDraftTodos")
    }
    function onCreateDraftTodo(todo) {
      console.log(currentPage.title + " Action - createDraftTodo: todo="+JSON.stringify(todo))
    }
    function onStoreDraftTodo(todo) {
      console.log(currentPage.title + " Action - storeDraftTodo: todo="+JSON.stringify(todo))
    }
    function onClearCache() {
      console.log(currentPage.title + " Action - clearCache")
    }
    function onIncrementNumberOfPages() {
      console.log(currentPage.title + " Action - IncrementNumberOfPages")
    }
  }

  // listen to model signals (to log storage success / errors)
  Connections {
    id: modelConnection

    // action success signals
    function onTodoStored(draftId, todoId) {
      console.log("Success - todoStored: draftId= "+draftId+", todoId="+todoId)
    }
    function onDraftTodoCreated(todo) {
      console.log("Success - draftTodoCreated: todo="+JSON.stringify(todo))
    }
    // action error signals
    function onFetchTodosFailed(error) {
      console.error("Error - fetchTodosFailed: error="+JSON.stringify(error))
    }
    function onFetchTodoDetailsFailed(id, error) {
      console.error("Error - fetchTodoDetailsFailed: id="+id+", error="+JSON.stringify(error))
    }
    function onStoreDraftTodoFailed(todo, error) {
      console.error("Error - storeDraftTodoFailed: todo="+JSON.stringify(todo)+", error="+JSON.stringify(error))
    }
  }
}
