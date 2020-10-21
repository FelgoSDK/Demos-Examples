import Felgo 3.0


App {
  NavigationStack {
    Page {
      id: page
      property int tapCount: 0
      title: "FloatingActionButton"

      AppText {
        anchors.centerIn: parent
        text: "Tapped " + page.tapCount + " times."
        visible: page.tapCount > 0
      }

      FloatingActionButton {
        icon: IconType.home
        visible: true // Show on all platforms, default is only Android
        onClicked: {
          page.tapCount++
        }
      }
    }
  }
}
