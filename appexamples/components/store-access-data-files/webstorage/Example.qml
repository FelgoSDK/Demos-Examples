import Felgo 3.0
import QtQuick 2.0


App {

  WebStorage {
    id: myWebStorage

    property int appStartedCounter

    onInitiallyInServerSyncOrErrorChanged: {
      // Also increase the app counter, if there is no internet connection
      if (initiallyInServerSyncOrError) {
        increaseAppStartedCounter()
      }
    }

    function increaseAppStartedCounter() {
      var appStarts = myWebStorage.getValue("numAppStarts")
      // If the app was started for the first time, this will be undefined; in that case set it to 1
      if (appStarts === undefined) {
        appStarts = 1
      } else {
        appStarts++
      }
      myWebStorage.setValue("numAppStarts", appStarts)

      // Set the property to the stored value
      appStartedCounter = appStarts
    }
  }

  NavigationStack {
    Page {
      title: "WebStorage"
      AppButton {
        // Show the current appStartedCounter value in the button
        anchors.centerIn: parent
        text: "Increase AppStartedCounter from current value " + myWebStorage.appStartedCounter
        onClicked: {
          // Increase the current appcounter value by 1
          myWebStorage.increaseAppStartedCounter()
        }
      }
    }
  }
}
