import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "NavigationBarRow"

      // Add a custom NavigationBarItem in the left slot of the NavigationBar
      rightBarItem: NavigationBarRow {
        // Row contains an activity indicator
        ActivityIndicatorBarItem {
          id: activityIndicator
        }

        // ... and an icon button
        IconButtonBarItem {
          icon: IconType.toggleon
          onClicked: { 
            console.log("item clicked") 
          }
        }
      }

      AppText {
        anchors.centerIn: parent
        text: "Check the cool navigation row"
      }
    }
  }
}

