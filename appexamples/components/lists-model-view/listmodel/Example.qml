import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {

    ListPage {
      id: listPage
      title: "ListModel"

      model: ListModel {
        id: fruitModel

        ListElement {
          name: "Apple"
          cost: 2.45
        }
        ListElement {
          name: "Orange"
          cost: 3.25
        }
        ListElement {
          name: "Banana"
          cost: 1.95
        }
      }

      delegate: AppText {
        height: dp(50)
        text: "Today " + "<b>"+ model.name + "</b> costs $" + model.cost
      }
    }
  }
}
