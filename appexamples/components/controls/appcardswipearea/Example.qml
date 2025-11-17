import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "AppCardSwipeArea"

      Column {
        anchors.centerIn: parent

        // You cannot use anchors directly on the item that needs to be swiped, as this blocks x and y movement
        // However you can still place it in layout components like a Column, as shown in this example
        AppPaper {
          width: dp(300)
          height: appText.height

          AppText {
            id: appText
            width: parent.width
            padding: dp(15)
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat."
          }

          // Fill the parent by default and uses it as target for the swipe
          AppCardSwipeArea {
            onSwipeOutCompleted: (direction) => {
              console.log("CardView swipe completed with direction " + direction)
            }
          }
        }
      }
    }
  }
}
