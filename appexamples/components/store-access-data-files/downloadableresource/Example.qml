import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "DownloadableResource"
      AppButton {
        id: downloadButton
        text: "Download and open test PDF"
        anchors.centerIn: parent
        onClicked: {
          if (downloadResource.status === DownloadableResource.UnAvailable) {
            downloadResource.download()
          } else {
            openDownloadedFile()
          }
        }
      }

      AppText {
        anchors {
          top: downloadButton.bottom
          horizontalCenter: parent.horizontalCenter
        }
        text: "DownloadableResource status: \n"
              + downloadResource.statusText
      }

      DownloadableResource {
        id: downloadResource
        source: "https://www.orimi.com/pdf-test.pdf"
        storageLocation: FileUtils.DocumentsLocation
        storageName: "pdf-test.pdf"
        extractAsPackage: false

        onStatusChanged: {
          openDownloadedFile()
        }
      }
    }
  }

  function openDownloadedFile() {
    if (downloadResource.status === DownloadableResource.Available) {
      fileUtils.openFile(downloadResource.storagePath)
    }
  }
}
