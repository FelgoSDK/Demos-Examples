import Felgo
import QtQuick


App {
  DownloadableResource {
    id: resource

    extractAsPackage: false // false for single files
    source: "https://felgo.com/wp-content/themes/felgo/images/felgo.png"
    Component.onCompleted: {
      download()
    }
  }

  NavigationStack {
    AppPage {
      title: "DownloadableResource"
      Column {
        anchors.centerIn: parent
        AppImage {
          width: dp(300)
          fillMode: Image.PreserveAspectFit
          source: resource.available ? resource.storagePath : ""
        }
        AppText {
          text: resource.available ? "Image available" : "Image is not available"
        }
      }
    }
  }
}
