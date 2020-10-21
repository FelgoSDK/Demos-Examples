import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    id: navigationStack

    Page {
      title: "NavigationStack"

      AppButton {
        anchors.centerIn: parent
        text: "Click me"

        onClicked: {
          // Add another page to the navigation stack. 
          // When back is pressed the page will be popped back.
          navigationStack.push(anotherPage)
        }
      }
    }

    // This component will be instantiated only when pushed on the stack
    Component {
      id: anotherPage
      Page {
        title: "Second Page"

        AppText {
          anchors.centerIn: parent
          text: "This is another page"
        }
      }
    }
  }
}
