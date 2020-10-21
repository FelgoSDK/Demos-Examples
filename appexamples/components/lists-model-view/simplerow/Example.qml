import Felgo 3.0


App {
  NavigationStack {
    Page {
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
