import Felgo 3.0
import QtQuick 2.0
import Qt.labs.settings 1.0


App {
  id: application

  Settings {
    id: settings
    property int numberAppStarts: 0
  }

  NavigationStack {
    Page {
      title: "Qt.labs.settings"

      AppText {
        anchors.centerIn: parent
        text: "Launches number: " + settings.numberAppStarts
      }
    }
  }

  Component.onCompleted: {
    // On first run numberAppStarts equals 0
    settings.numberAppStarts++
  }
}
