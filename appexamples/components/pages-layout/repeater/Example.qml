import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "Repeater"

      Column {
        anchors.fill: parent

        // Given a model (in this case just a number) Repeater will instantiate delegates
        Repeater {
          model: 10
          delegate: SimpleRow {
            text: "Item " + index
          }
        }
      }
    }
  }
}

