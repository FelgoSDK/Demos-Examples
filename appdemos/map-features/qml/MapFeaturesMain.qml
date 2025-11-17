import Felgo
import QtQuick


App {
  id: app

  color: "black"

  NavigationStack {
    id: navigationStack

    initialPage: homePage
  }

  Component {
    id: homePage

    ListPage {
      title: qsTr("Select map feature")

      model: MapFeaturesModel {}

      delegate: SimpleRow {
        text: pageName

        onSelected: {
          navigationStack.push(Qt.resolvedUrl(pageUrl))
        }
      }
    }
  }
}
