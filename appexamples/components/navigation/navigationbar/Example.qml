import Felgo 4.0


App {
  NavigationStack {
    id: navigationStack

    AppPage {
      title: "NavigationBar"

      AppButton {
        text: "Click me"
        anchors.centerIn: parent

        onClicked: {
          // Access the navigation bar and programmatically change the background color
          navigationStack.navigationBar.backgroundColor = randomColor()
        }

        function randomColor() {
          return Qt.hsla(Math.random(), 0.5, 0.5, 1.0)
        }
      }
    }
  }
}

