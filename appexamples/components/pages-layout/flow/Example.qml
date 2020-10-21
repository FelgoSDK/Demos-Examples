import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "Flow"

      property real textSize: 16

      Flow {
        anchors.fill: parent
        anchors.margins: dp(16)
        spacing: 10

        AppText { text: "Look"; fontSize: page.textSize }
        AppText { text: "at how"; fontSize: page.textSize }
        AppText { text: "element"; fontSize: page.textSize }
        AppText { text: "flow "; fontSize: page.textSize }
        AppText { text: "naturally "; fontSize: page.textSize }
        AppText { text: "on "; fontSize: page.textSize }
        Icon { icon: IconType.apple }
        AppText { text: ", "; fontSize: page.textSize }
        Icon { icon: IconType.android }
        AppText { text: "and "; fontSize: page.textSize }
        Icon { icon: IconType.desktop }
      }
    }
  }
}
