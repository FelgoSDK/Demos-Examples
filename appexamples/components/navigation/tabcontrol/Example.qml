import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "TabControl"

      TabControl {
        NavigationItem {
          title: "Tab 1"
          iconType: IconType.arrowleft

          AppPage {
            AppText {
              anchors.centerIn: parent
              text: "Tab 1 Content"
            }
          }
        }
        NavigationItem {
          title: "Tab 2"
          iconType: IconType.arrowright

          AppPage {
            AppText {
              anchors.centerIn: parent
              text: "Tab 2 Content"
            }
          }
        }
      }
    }
  }
}
