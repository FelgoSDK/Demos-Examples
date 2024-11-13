import Felgo 4.0
import QtQuick 2.0


App {
  property bool applicationFirstStart: false

  Storage {
    id: localStorage

    Component.onCompleted: {
      var weWereHere = localStorage.getValue("weWereHere")
      if (weWereHere === undefined) {
        // This means the app was not started before
        applicationFirstStart = true
      }

      // Now the application was started at least once, so set the flag to true
      localStorage.setValue("weWereHere", true)
    }
  }

  NavigationStack {
    AppPage {
      title: "Storage"

      AppText {
        anchors.centerIn: parent
        text: "Visible only on first start"
        visible: applicationFirstStart
      }
    }
  }
}
