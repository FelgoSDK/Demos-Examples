import QtQuick
import QtQuick.Controls
import Felgo

ApplicationWindow {
  title: qsTr("Qt App")
  width: 640
  height: 480
  visible: true

  GameWindowItem {
    // licenseKey: "<your-license-key>"
  }

  // Example 1: Local Storage
  Storage {
    id: storage
    property int counter: storage.getValue("counter") || 0
    function increaseCounter() {
      counter++
      storage.setValue("counter", counter)
    }
  }

  Button {
    id: increaseCountButton
    text: "Count: "+storage.counter
    onClicked: storage.increaseCounter()
    anchors.centerIn: parent
  }

  // Example 2: Download and Open PDF
  Button {
    text: "Download / Open PDF"
    onClicked: {
      if(pdfResource.available) openPdf()
      else pdfResource.download()
    }
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: increaseCountButton.bottom
    anchors.margins: 5
  }

  DownloadableResource {
    id: pdfResource
    source: "http://www.orimi.com/pdf-test.pdf"
    storageLocation: FileUtils.DocumentsLocation
    storageName: "pdf-test.pdf"
    extractAsPackage: false
    // if the download is competed, available will be set to true
    onAvailableChanged: if(available) openPdf()
  }

  function openPdf() {
    fileUtils.openFile(pdfResource.storagePath)
  }

  // Example 3: Felgo Plugin Usage
  Amplitude {
    id: amplitude

    // From Amplitude Settings
    apiKey: "<amplitude-api-key>"

    onPluginLoaded: {
      amplitude.logEvent("App started");
    }
  }
}
