import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "AppListView"

      AppListView {
        delegate: SimpleRow { }
        model: [
          {
            text: "Widget test",
            detailText: "Some of the widgets available in Felgo AppSDK",
            icon: IconType.tablet
          },
          {
            text: "Shown are:",
            detailText: "ListPage, NavigationBar with different items, Switch",
            icon: IconType.question
          }
        ]
      }
    }
  }
}

