import QtQuick 2.0
import Felgo 3.0

Item {

  // property to configure target dispatcher / logic
  property alias dispatcher: logicConnection.target

  // whether api is busy (ongoing network requests)
  readonly property bool isBusy: api.busy

  // whether todos are currently being fetched
  readonly property bool isFetchingTodos: _.isFetchingTodos

  // whether a storeTodo request is running
  readonly property bool isStoringTodos: _.storeTodoRequests > 0

  // model data properties
  readonly property var todos: _.storedTodos.concat(_.todos)
  readonly property alias todoDetails: _.todoDetails
  readonly property alias draftTodos: _.draftTodos

  // paging settings
  readonly property alias fetchedPages: _.fetchedPages
  readonly property alias totalPages: _.totalPages
  readonly property int todosPerPage: 25

  // action success signals
  signal draftTodoCreated(var todo)
  signal todoStored(int draftId, int todoId)

  // action error signals
  signal fetchTodosFailed(var error)
  signal fetchTodoDetailsFailed(int id, var error)
  signal storeDraftTodoFailed(var todo, var error)

  // listen to actions from dispatcher
  Connections {
    id: logicConnection

    // action 1 - fetchTodos
    onFetchTodos: {
      // check cached value first
      var cached = cache.getValue("todos")
      if(cached)
        _.todos = cached

      // load from api
      _.isFetchingTodos = true
      api.getTodos(
            function(data) {
              // cache data before updating model property
              cache.setValue("todos",data)

              // note: the dummy API does not support paging
              // we thus actually fetch all items and slice the result here
              _.todos = data.slice(0, fetchedPages * todosPerPage)
              _.totalPages = Math.ceil(data.length / todosPerPage)
              _.isFetchingTodos = false
            },
            function(error) {
              // action failed if no cached data
              if(!cached)
                fetchTodosFailed(error)
              _.isFetchingTodos = false
            })

      // also fetch stored todos from cache, dummy REST API doesn't store new todos
      var stored = cache.getValue("storedTodos")
      if(stored)
        _.storedTodos = stored
    }

    // action 2 - fetchTodoDetails
    onFetchTodoDetails: {
      // fetch from drafts if id < 0
      if(id < 0) {
        _.draftTodos.forEach(function(item) {
          if(item.id === id) {
            _.todoDetails[id] = item
          }
        })
        return
      }

      // check cached todo details first
      var cached = cache.getValue("todo_"+id)
      if(cached) {
        _.todoDetails[id] = cached
        todoDetailsChanged() // signal change within model to update UI
      }

      // load from api
      api.getTodoById(id,
                      function(data) {
                        // cache data first
                        cache.setValue("todo_"+id, data)
                        _.todoDetails[id] = data
                        todoDetailsChanged()
                      },
                      function(error) {
                        // action failed if no cached data
                        if(!cached) {
                          fetchTodoDetailsFailed(id, error)
                        }
                      })
    }

    // action 3 - fetchDraftTodos
    onFetchDraftTodos: {
      // check cached value first
      var cached = cache.getValue("draftTodos")
      if(cached)
        _.draftTodos = cached

      // drafts are not stored with api, only locally in cache
    }

    // action 4 - createDraftTodo
    onCreateDraftTodo: {
      // create a copy, do not change the passed data object from caller
      var todoCopy = JSON.parse(JSON.stringify(todo))

      // add id and save in drafts
      var latestDraftNr = -(_.todosCount + _.draftTodos.length)
      todoCopy["id"] = latestDraftNr - 1 // negative id means its a draft
      _.draftTodos.unshift(todoCopy) // add to top of draft list

      // cache draft todos
      cache.setValue("draftTodos", _.draftTodos)
      draftTodosChanged()

      // drafts are not stored with api, only locally
      draftTodoCreated(todoCopy)
    }

    // action 5 - storeDraftTodo
    onStoreDraftTodo: {
      // create a copy, do not change the passed data object from caller
      var todoCopy = JSON.parse(JSON.stringify(todo))

      // remove draftId, api expects no id and assigns a new one
      delete todoCopy["id"]

      // store with api
      _.storeTodoRequests++
      api.addTodo(todoCopy,
                  function(data) {
                    // NOTE: Dummy REST API always returns 201 as id of new todo
                    // To simulate a new todo, we set correct local id based on current model
                    data.id = (todo.id * -1)

                    // cache newly added item details
                    cache.setValue("todo_"+data.id, data)

                    // remove draft item
                    for(var i=0; i < _.draftTodos.length; i++) {
                      if(_.draftTodos[i].id === todo.id) {
                        _.draftTodos.splice(i, 1)
                      }
                    }

                    // add new item to stored todos
                    _.storedTodos.unshift(data)

                    // cache updated todo list and drafts
                    cache.setValue("draftTodos", _.draftTodos)
                    cache.setValue("storedTodos", _.storedTodos)
                    draftTodosChanged()
                    _.storedTodosChanged()

                    todoStored(todo.id, data.id)
                    _.storeTodoRequests--
                  },
                  function(error) {
                    storeDraftTodoFailed(todo, error)
                    _.storeTodoRequests--
                  })
    }

    // action 6 - clearCache
    onClearCache: {
      // only clear todos and details, not drafts
      cache.clearValue("todos")
      Object.keys(_.todoDetails).forEach(function(id) {
        cache.clearValue("todo_"+id)
      })
    }

    // action 7 - incrementNumberOfPages
    onIncrementNumberOfPages: _.fetchedPages++
  }

  // only place getter functions here that do not modify the data
  // pages trigger write operations through logic signals only

  // isDraft - function to check whether a todo is a draft
  function isDraft(todo) {
    var isDraft = false

    if(!!todo) {
      for(var i = 0; i < _.draftTodos.length; i++) {
        if(_.draftTodos[i].id === todo.id) {
          isDraft = true
          break
        }
      }
    }

    return isDraft
  }

  // rest api for data access
  RestAPI {
    id: api
    maxRequestTimeout: 3000 // use max request timeout of 3 sec
  }

  // storage for caching
  Storage {
    id: cache
  }

  // private
  Item {
    id: _

    // data properties
    property var todos: []
    property var todoDetails: ({})
    property var draftTodos: []

    property var storedTodos: [] // dummy REST api can't actually store todos, we thus hold them locally
    property int todosCount: 200 + storedTodos.length // 200 initial count, as dummy REST api always has 200 todos

    // properties for request state reporting
    property int storeTodoRequests: 0

    property bool isFetchingTodos: false

    // paging setting
    property int fetchedPages: 1
    property int totalPages: 1
  }
}
