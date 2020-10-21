import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
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

