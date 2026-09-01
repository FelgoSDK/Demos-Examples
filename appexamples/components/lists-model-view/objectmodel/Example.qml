import Felgo
import QtQuick
import QtQml.Models


App {
  NavigationStack {
    AppPage {
      title: "ObjectModel"

      // Define qml objects in ObjectModel
      ObjectModel {
        id: objectModel
        SimpleRow { text: "Text 1" }
        SimpleRow { text: "Text 2" }
        SimpleRow { text: "Text 3" }
        SimpleRow { text: "Text 4" }
        SimpleRow { text: "Text 5" }
        SimpleRow { text: "Text 6" }
        SimpleRow { text: "Text 7" }
      }

      AppListView {
        id: gridView
        anchors.fill: parent
        model: objectModel
      }
    }
  }
}
