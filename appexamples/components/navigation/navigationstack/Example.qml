import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    id: navigationStack

    AppPage {
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
      AppPage {
        title: "Second Page"

        AppText {
          anchors.centerIn: parent
          text: "This is another page"
        }
      }
    }
  }
}
