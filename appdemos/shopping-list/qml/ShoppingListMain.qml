import Felgo
import QtQuick
import "model"

// The app is the manager of your class. It owns the different components
// like the pages and the data model. Also, it connects the individual
// signals from its sub-components to corresponding slots.
App {
  id: app
  // TODO: You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  // The data model manages the shopping list data and authentication
  // in the Google Firebase Realtime Database.
  // It also abstracts the Google Firebase database, so that
  // the rest of your application doesn't need to worry about
  // how exactly the data is stored or accessed.
  DataModel {
    id: dataModel
    // After the login-process has been finished successfully,
    // navigate from the login page to the shopping list page
    onLoggedIn: stack.push(shoppingListPage)
  }

  NavigationStack {
    id: stack

    // Initially, the login page is always visible when starting the app.
    LoginPage {
      id: loginPage

      // The login page contains a form to enter user name and password.
      // A checkbox lets the user choose whether to log in or to register a
      // new user. In both cases, this slot is called.
      onLogin: (isRegister, email, password) => {
        if(isRegister) {
          // Call the user registration method from our data model,
          // which then forwards the request to Google Firebase
          dataModel.registerUser(email, password)
        } else {
          // Similar approach sending a user login request to Firebase.
          dataModel.loginUser(email, password)
        }
      }
    }
  }

  // The main shopping list page, which will be pushed to the
  // navigation stack after the login process has been completed
  // successfully.
  Component {
    id: shoppingListPage
    MasterPage {
      // Slots of the master page
      // User added a new shopping item -> forward the request to the data model.
      onAddNewShoppingItem: text => dataModel.addShoppingItem(text)
      // User deleted a shopping item -> forward the request to the data model.
      onDeleteShoppingItem: id => dataModel.deleteShoppingItem(id)
      // User would like to see the details of the shopping item -> navigate to the detail page
      onShowShoppingItemDetails: shoppingItem => stack.push(shoppingItemDetailsPage, {shoppingItem: shoppingItem})
      // User navigated back in the UI - send logout request to Firebase
      onPopped: dataModel.logoutUser()
    }
  }

  // The shopping item detail page, which shows additional information
  // and allows changing the shopping item text.
  Component {
    id: shoppingItemDetailsPage

    DetailPage {
      // User changed details of the shopping item
      // -> forward the request to the data model to update it in the
      // Google Firebase Realtime Database
      onSaveShoppingItem: shoppingItem => {
        dataModel.saveShoppingItem(shoppingItem)
        // After saving, navigate back to the shopping list page.
        stack.pop()
      }
    }
  }
}
