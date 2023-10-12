import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "PullToRefreshHandler"

      AppListView {
        id: listView

        model: 5
        anchors.fill: parent

        delegate: SimpleRow {
          text: index
        }

        PullToRefreshHandler {
          // At each refresh we add another couple of items to the listview
          onRefresh: listView.model += 2
        }
      }
    }
  }
}
