import Felgo


App {
  NavigationStack {
    AppPage {
      title: "AppListView"

      AppListView {
        delegate: SimpleRow {
          onSelected: {
            // Here we handle selection. We currently only print what was selected.
            console.log("Clicked Item #" + index + ": " + JSON.stringify(modelData))
          }
        }
        // Model is defined by a simple json array in this case.
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
