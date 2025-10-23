import Felgo


App {
  NavigationStack {

    AppPage {
      id: page
      title: "Hide Navigation Bar"

      // This is the default, the NavigationStack shows a navigation bar for this page
      navigationBarHidden: false

      AppButton {
        anchors.centerIn: parent
        text: "Show/Hide Navigation Bar"

        onClicked: {
          // When clicked, we switch the navigationBarHidden property
          page.navigationBarHidden = !page.navigationBarHidden
        }
      }
    }
  }
}
