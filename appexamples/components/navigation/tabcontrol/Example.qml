import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "TabControl"

      TabControl {
        NavigationItem {
          title: "Tab 1"
          icon: IconType.arrowleft

          Page {
            AppText {
              anchors.centerIn: parent
              text: "Tab 1 Content"
            }
          }
        }
        NavigationItem {
          title: "Tab 2"
          icon: IconType.arrowright

          Page {
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
