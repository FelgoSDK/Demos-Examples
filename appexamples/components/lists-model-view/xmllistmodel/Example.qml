import Felgo 3.0
import QtQuick.XmlListModel 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "XmlListModel"

      XmlListModel {
        id: xmlModel
        // Source can be a remote url
        source: "assets/xml-model.xml"
        query: "/rss/channel/item"

        // Roles will be exposed as properties inside the delegate
        XmlRole {
          name: "title"
          query: "title/string()"
        }
        XmlRole {
          name: "pubDate"
          query: "pubDate/string()"
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
