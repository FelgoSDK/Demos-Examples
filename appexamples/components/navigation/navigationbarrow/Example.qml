import Felgo 4.0


App {
  NavigationStack {
    AppPage {
      title: "NavigationBarRow"

      // Add a custom NavigationBarItem in the left slot of the NavigationBar
      rightBarItem: NavigationBarRow {
        // Row contains an activity indicator
        ActivityIndicatorBarItem {
          id: activityIndicator
        }

        // ... and an icon button
        IconButtonBarItem {
          iconType: IconType.toggleon
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

