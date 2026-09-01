import QtQuick

Item {

  // function to format the todo title for display
  // appends draft number for drafts
  function formatTodoId(todo) {
    if(!todo)
      return ""

    return qsTr("Todo") + " " + (todo.id < 0 ? (-todo.id) + " (Draft)" : todo.id)
  }


}
