import Felgo


App {
  NavigationStack {
    AppPage {
      title: "Swipe-able List"

      AppListView {
        anchors.fill: parent
        model: [
          { text: "Item 1" },
          { text: "Item 2" },
          { text: "Item 3" }
        ]

        delegate: SwipeOptionsContainer {
          id: container

          // Swipe container uses the height of the list item
          height: listItem.height
          SimpleRow { id: listItem }

          // Set an item that shows when swiping to the right
          leftOption: SwipeButton {
            iconType: IconType.gear
            height: parent.height
            onClicked: {
              listItem.text = "Option clicked"
              container.hideOptions() // hide button again after click
            }
          }
        }
      }
    }
  }
}
