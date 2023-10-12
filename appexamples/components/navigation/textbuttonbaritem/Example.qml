import Felgo 3.0


App {
  NavigationStack {
    Page {
      id: page
      title: "TextButtonBarItem"

      leftBarItem: TextButtonBarItem {
        text: "Action 1"
        onClicked: {
          label.text = "Thanks from Action 1"
        }
      }

      rightBarItem: TextButtonBarItem {
        text: "Action 2"
        onClicked: {
          label.text = "Thanks from Action 2"
        }
      }

      AppText {
        id: label
        anchors.centerIn: parent
        text: "Try clicking our TextButtonBarItems"
      }
    }
  }
}
