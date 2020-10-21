import Felgo 3.0
import QtQuick.XmlListModel 2.0


App {
  // Model for loading and parsing xml data
  XmlListModel {
    id: xmlModel
    // Set xml source to load data from local file or web service
    source: "assets/data.xml"
    // Set query that returns items
    query: "/data/item"
    // Specify roles to access item data
    XmlRole {
      name: "itemText"
      query: "string()"
    }
  }

  NavigationStack {
    // Display the xml model in a list
    ListPage {
      id: page
      title: "Parse XML"
      model: xmlModel
      delegate: SimpleRow { text: itemText }
    }
  }
}
