import Felgo 3.0


App {
  NavigationStack {
    Page {
      id: page
      title: "AppImage"

      AppImage {
        anchors.centerIn: parent
        width: dp(200)
        height: dp(200)

        // We are scaling the image without any cropping or stretching
        fillMode: AppImage.PreserveAspectFit

        defaultSource: "assets/felgo-logo.png"
      }
    }
  }
}
