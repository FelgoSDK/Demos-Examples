import Felgo


App {
  NavigationStack {
    ListPage {
      title: "SwipeOptionsContainer"
      // Some JS array as list model
      model: [
        { text: "Item 1", detailText: "Detail 1" },
        { text: "Item 2", detailText: "Detail 2" }
      ]

      // Define the SwipeOptionsContainer as delegate
      delegate: SwipeOptionsContainer {
        id: container

        // Actual content to be displayed in the list rows
        SimpleRow {
          id: row
        }

        // Left options, displayed when swiped list row to the right
        leftOption: SwipeButton {
          text: "Option"
          iconType: IconType.gear
          height: row.height
          onClicked: {
            row.item.text = "Option clicked"
            row.itemChanged()
            // Hide automatically when button clicked
            container.hideOptions()
          }
        }

        // Right options, displayed when swiped list row to the left
        rightOption: AppActivityIndicator {
          height: row.height
          width: height
        }
      }
    }
  }
}
