import Felgo


App {
  NavigationStack {
    AppPage {
      title: "AppListView"

      AppListView {
        delegate: SimpleRow { }
        model: [
          {
            text: "Widget test",
            detailText: "Some of the widgets available in Felgo AppSDK",
            iconType: IconType.tablet
          },
          {
            text: "Shown are:",
            detailText: "ListPage, NavigationBar with different items, Switch",
            iconType: IconType.question
          }
        ]
      }
    }
  }
}

