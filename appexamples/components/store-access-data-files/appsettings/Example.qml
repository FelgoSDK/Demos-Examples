import Felgo 3.0
import QtQuick 2.0


App {
  // Property holds a number of application launches
  property int numberAppStarts

  NavigationStack {
    Page {
      title: "App.settings"

      AppText {
        anchors.centerIn: parent
        text: "Launches number: " + numberAppStarts
      }
    }
  }

  Component.onCompleted: {
    // Reads the numberAppStarts value from the database
    // On the first start of the app there is no setting for given key is found, so getValue() returns undefined
    var tempNumberAppStarts = settings.getValue("numberAppStarts")
    if (tempNumberAppStarts === undefined) {
      tempNumberAppStarts = 1
    } else {
      tempNumberAppStarts++
    }
    settings.setValue("numberAppStarts", tempNumberAppStarts)
    numberAppStarts = tempNumberAppStarts
  }
}
