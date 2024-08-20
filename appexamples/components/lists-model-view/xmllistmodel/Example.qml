import Felgo 4.0
import QtQml.XmlListModel

App {
  NavigationStack {
    AppPage {
      id: page
      title: "XmlListModel"

      XmlListModel {
        id: xmlModel
        // Source can be a remote url
        source: "assets/xml-model.xml"
        query: "/rss/channel/item"

        // Roles will be exposed as properties inside the delegate
        XmlListModelRole {
          name: "title"
          elementName: "title"
        }
        XmlListModelRole {
          name: "pubDate"
          elementName: "pubDate"
        }
      }

      AppListView {
        anchors.fill: parent
        model: xmlModel
        delegate: SimpleRow {
          text: title
          detailText: pubDate
        }
      }
    }
  }
}
