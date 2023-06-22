import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "fileUtils"

      Column {
        anchors.centerIn: parent

        AppButton {
          text: "Download and Open PDF"
          onClicked: {
            if (pdfResource.available) {
              openPdf()
            } else {
              pdfResource.download()
            }
          }
        }
        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Status: " + pdfResource.status
        }
      }
    }
  }

  DownloadableResource {
    id: pdfResource
    source: "https://www.orimi.com/pdf-test.pdf"
    storageLocation: FileUtils.DocumentsLocation
    storageName: "pdf-test.pdf"
    extractAsPackage: false
    // If the download is competed, available will be set to true
    onAvailableChanged: {
      if (available) {
        openPdf()
      }
    }
  }

  function openPdf() {
    // You can also open files with nativeUtils.openUrl() now (for paths starting with "file://")
    // nativeUtils.openUrl(pdfResource.storagePath)
    fileUtils.openFile(pdfResource.storagePath)
  }
}
