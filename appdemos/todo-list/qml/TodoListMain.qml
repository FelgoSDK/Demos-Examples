import Felgo 3.0
import QtQuick 2.0
import "model"
import "logic"
import "pages"
import "ui"

App {
  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  // app initialization
  Component.onCompleted: {
    // if device has network connection, clear cache at startup
    // you'll probably implement a more intelligent cache cleanup for your app
    // e.g. to only clear the items that aren't required regularly
    if(isOnline) {
      logic.clearCache()
    }

    // fetch todo list data
    logic.fetchTodos()
    logic.fetchDraftTodos()
  }

  onInitTheme: {
    Theme.colors.tintColor = colorsManager.getBaseColor()
  }

  // business logic
  Logic {
    id: logic
  }

  ColorsManager {
    id: colorsManager
  }

  // model
  DataModel {
    id: dataModel
    dispatcher: logic // data model handles actions sent by logic

    // global error handling
    onFetchTodosFailed: nativeUtils.displayMessageBox(qsTr("Unable to load todos"), error, 1)

    // we do not require a global error handler when fetching details fails
    // the TodoDetailPage shows cached data and loading state if no data available
    // onFetchTodoDetailsFailed: nativeUtils.displayMessageBox(qsTr("Unable to load todo ")+id, error, 1)

    // we always keep the new todos as a draft in this example, so storing drafts can also silently fail
    // TodoDetailPage still handles it if storing fails after the user clicks the save button
    // onStoreDraftTodoFailed: nativeUtils.displayMessageBox(qsTr("Failed to store ")+ViewHelper.formatTitle(todo))
  }

  // logging (console)
  ConsoleLogger {
    dispatcher: logic
    logicLogging: true // set false to disable logging for logic actions

    model: dataModel
    modelLogging: true // set false to disable logging signals model signals
    currentPage: stack.currentPage
  }

  // helper functions for view
  ViewHelper {
    id: viewHelper
  }

  // view
  NavigationStack {
    id: stack
    splitView: tablet // use side-by-side view on tablets
    initialPage: TodoListPage { }
  }
}
