import Felgo 3.0


App {
  NavigationStack {
    Page {
      id: page
      title: "IconButtonBarItem"

      rightBarItem: IconButtonBarItem {
        icon: IconType.gear
        onClicked: {
          text.text = "Thanks from right side"
        }
      }

      leftBarItem: IconButtonBarItem {
        icon: IconType.gears
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

