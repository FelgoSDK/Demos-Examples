import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "IconButtonBarItem"

      rightBarItem: IconButtonBarItem {
        iconType: IconType.gear
        onClicked: {
          text.text = "Thanks from right side"
        }
      }

      leftBarItem: IconButtonBarItem {
        iconType: IconType.gears
        onClicked: {
          text.text = "Thanks from left side"
        }
      }

      AppText {
        id: text
        anchors.centerIn: parent
        text: "Try clicking our gears icons"
      }
    }
  }
}

