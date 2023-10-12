import QtQuick 2.0

Item {

  // actions
  signal fetchTodos()

  signal fetchTodoDetails(int id)

  signal fetchDraftTodos()

  signal createDraftTodo(var todo)

  signal storeDraftTodo(var todo)

  signal clearCache()

  signal incrementNumberOfPages()

  // function to add a new draft
  function addNewDraftTodo(title) {
    var draft = {
      completed: false,
      title: title,
      userId: 1,
    }

    createDraftTodo(draft)
  }

  function fetchNextPage() {
    incrementNumberOfPages()
    fetchTodos()
  }
}
