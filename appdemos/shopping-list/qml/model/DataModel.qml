import Felgo 3.0
import QtQuick 2.5

// The data model manages the interaction with the Google Firebase Realtime Database.
// This includes user authentication as well as managing items in the cloud database.
// The data model abstracts the Firebase interaction and provides easy-to-use methods
// and signals so that the rest of the app does not need to know about the implementation
// details of Google Firebase.
Item {
  id: dataModel

  // Stores a list of all shopping items for the user
  property var shoppingItems: ({})

  // Name of the root node for the user's shopping items in the Firebase database
  readonly property string dbKeyAllShoppingItems: "shoppinglist-user"

  // Signal is emitted when the user has successfully logged in.
  // This triggers navigating from the login page to the shopping list page (MasterPage).
  signal loggedIn
  // Signal is emitted when the user logs out
  signal loggedOut


  // -------------------------------------------------------------------------------------
  // Google Firebase Realtime Database Configuration

  // The fbConfig element contains the basic configuration of the Firebase database
  // You can retrieve the required parameters and settings from your cloud
  // console at https://console.firebase.google.com/
  FirebaseConfig {
    id: fbConfig

    // TODO: update the project ID, from project_info | project_number
    projectId: "shoppinglist-v-play"
    // TODO: update the database URL, from project_info | firebase_url
    databaseUrl: "https://shoppinglist-v-play.firebaseio.com"

    // TODO: update the API keys for Android and/or iOS, from client | api_key | current_key
    apiKey: Qt.platform.os === "android"
            ? "AIzaSyDD3p4fdljhaeTu91XCJBOSs3cAQquS8Cc"
            : "AIzaSyACSCxsBrOa4XKl5pGc0Vb5Ps4Rw21_o4o"

    // TODO: update the application ID for Android and/or iOS, from client | client_info | mobilesdk_app_id
    applicationId: Qt.platform.os === "android"
                   ? "1:251103824113:android:a28d26d18b381c88"
                   : "1:251103824113:ios:a28d26d18b381c88"

  }

  // -------------------------------------------------------------------------------------
  // Google Firebase Realtime Authentication Handling

  // The Firebase authentication module takes care of registering new users,
  // as well as logging in users.
  FirebaseAuth {
    id: auth
    // Reference to the FirebaseConfig item
    config: fbConfig

    // Slot executed when a login-process has finished - no matter if successful
    // or not.
    onLoggedIn: {
      loadingFinished()
      // In case logging in wasn't successful, show a message box to inform the user.
      // If login worked, the onAuthenticationChanged slot will be called.
      if(!success) nativeUtils.displayMessageBox(qsTr("Login failed"), qsTr("Reason: %1").arg(message), 1)
    }
    onUserRegistered: {
      loadingFinished()
      // If registering a new user wasn't successful, show a message box with the reason.
      // If user registration worked, the onAuthenticationChanged slot will be called.
      if(!success) nativeUtils.displayMessageBox(qsTr("Register failed"), qsTr("Reason: %1").arg(message), 1)
    }

    // This slot is called every time the authentication status of the user changes.
    // It's very convenient, as this is the main focus on where the app gets
    // information on the current status of the user. When a login was successful,
    // this class will emit the signal that causes pushing the shopping list items page
    // to the navigation stack.
    // You could also handle the status if the user has logged out here, e.g., to ensure
    // that the user is brought back to the login page.
    onAuthenticatedChanged: if(authenticated) dataModel.loggedIn()
  }

  // Common function that is called from various places in this app
  // whenever a remote process has finished. You could use this to
  // hide any existing progress indicator.
  function loadingFinished() {
    console.log("Loading finished")
  }

  // Function to be used from the rest of the app to register a new user in
  // the Google Firebae Realtime Database.
  function registerUser(email, password) {
    auth.registerUser(email, password)
  }

  // Function to login based on existing email / password based authentication
  // for users that have already registered.
  function loginUser(email, password) {
    auth.loginUser(email, password)
  }

  // Log out from the Google Realtime Database.
  function logoutUser() {
    // logout is instant and always works (there is no callback)
    auth.logoutUser()
  }

  // -------------------------------------------------------------------------------------
  // Google Firebase Realtime Database Handling

  // This item manages the interaction with the Google Firebase Realtime Database.
  FirebaseDatabase {
    id: database
    // Reference to the FirebaseConfig item
    config: fbConfig

    // List of keys where the app will receive real-time updates whenever the
    // data changes in the cloud.
    realtimeUserValueKeys: [dbKeyAllShoppingItems]

    // This signal gets emitted whenever the monitored items are changed in the cloud.
    // If the last shopping item gets deleted, the database returns null
    // the plugin then gives success==false, so don't check the success parameter
    onRealtimeUserValueChanged: if(key === dbKeyAllShoppingItems) shoppingItemsLoaded(value)
    // For information only: status update when the Firebase database is ready to
    // be accessed. You could add status handling for more elaborate error or
    // loading progress notifications.
    onFirebaseReady: console.log("db ready")
    // For information only: write has been completed. You could use this to inform the user
    // when the operation has been successfully completed, or to hide progress indicators.
    onWriteCompleted: console.log("write completed")
  }

  // Function that updates the internal data storage whenever the values
  // have changed in the Google Firebase Realtime Database in the cloud.
  function shoppingItemsLoaded(value) {
    // When the last item is deleted, firebase deletes the whole structure, returning null
    dataModel.shoppingItems = value || {}
    console.log(JSON.stringify(dataModel.shoppingItems))
  }

  // Add a shopping item with the specified text to the realtime database.
  // Its ID and time stamp are automatically generated based on the current system time.
  function addShoppingItem(text) {
    var time = new Date().getTime()
    var shoppingItem = {
      date: time,
      text: text
    }
    console.log("Adding item...")
    // Use date milliseconds as unique ID in DB
    database.setUserValue(dbKeyAllShoppingItems + "/" + time, shoppingItem, loadingFinished)
  }

  // Update an existing shopping item, based on its date as ID.
  function saveShoppingItem(shoppingItem) {
    // Date is unique ID in DB
    database.setUserValue(dbKeyAllShoppingItems + "/" + shoppingItem.date, shoppingItem, loadingFinished)
  }

  // Delete the shopping item through its ID (= the date in our scenario)
  function deleteShoppingItem(id) {
    database.setUserValue(dbKeyAllShoppingItems + "/" + id, null, loadingFinished)
  }

}
