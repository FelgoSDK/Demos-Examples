import Felgo


App {
  NavigationStack {
    AppPage {
      id: page
      title: "RippleMouseArea"

      // It's used as a simple MouseArea, you can customize the look and feel if you want
      RippleMouseArea {
        anchors.fill: parent

        AppText {
          anchors.centerIn: parent
          text: "Click me on Android"
        }
      }
    }
  }
}
