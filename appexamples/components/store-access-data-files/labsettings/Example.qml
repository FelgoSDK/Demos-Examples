import Felgo
import QtQuick
import Qt.labs.settings


App {
  id: application

  Settings {
    id: settings
    property int numberAppStarts: 0
  }

  NavigationStack {
    AppPage {
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
