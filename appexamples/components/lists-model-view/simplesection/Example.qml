import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      title: "AppListView"

      AppListView {
        model: ListModel {
          ListElement { type: "Fruits"; name: "Banana" }
          ListElement { type: "Fruits"; name: "Apple" }
          ListElement { type: "Vegetables"; name: "Potato" }
          ListElement { type: "Vegetables"; name: "Carrot" }
        }
        delegate: SimpleRow { text: name }

        section.property: "type"
        
        // As a section delegate we set a simple section.
        section.delegate: SimpleSection { }
      }
    }
  }
}
