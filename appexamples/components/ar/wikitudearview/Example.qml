import QtQuick.Controls 2.0
import QtQuick 2.0
import Felgo 3.0


App {
  // Name of the Wikitude example to load
  property string example: "11_Video_4_Bonus-TransparentVideo"
  readonly property bool exampleIsLoaded: samplesDl.available
  licenseKey: ""

  // NavigationStack can display Pages and adds a NavigationBar
  NavigationStack {
    id: navStack
    // At startup show either arPage or downloadPage, in case the example is not loaded yet
    Component.onCompleted: navStack.push(exampleIsLoaded ? arPage : downloadPage)
  }

  // arPage: Page with a Wikitude view
  property Component arPage: Page {
    title: "AR Example"

    // Configure Wikitude view
    WikitudeArView {
      id: arView
      anchors.fill: parent
      arWorldSource: samplesDl.getExtractedFileUrl(example + "/index.html")
      running: true
      cameraPosition: WikitudeArView.BackCamera

      // License key for Felgo QML Live app
      licenseKey: "g0q44ri5X4TwuXQ/9MDYmZxsf2qnzTdDIyR2dWhO6IUkLSLU4IltPMLWFirdj+7kFZOdWAhRUD6fumVXLXMZe6Y1iucswe1Lfa5Q7HhQvPxEq0A7uSU8sfkHLPrJL0z5e72DLt7qs1h25RJvIOiRGDoRc/h/tCWwUdOL6ChDnyJTYWx0ZWRfX8Vh9c9kcuw4+pN/0z3srlwIHPV5zJuB1bixlulM4u1OBmX4KFn+4+2ASRCNI+bk655mIO/Pk3TjtYMrgjFR3+iYHvw1UmaYMVjsrgpcVkbzJCT6QmaW8LejnfXDNLAbZSov64pVG/b7z9IZPFLXxRSQ0MRLudoSDAh6f7wMTQXQsyqGrZeuQH1GSWtfjl/geJYOvQyDI+URF58B5rcKnrX6UZW3+7dP92Xg4npw7+iGrO1M4In/Wggs5TXrmm25v2IYOGhaxvqcPCsAvbx+mERQxISrV+018fPpL8TzR8RTZZ5h7PRfqckZ3W54U1WSiGn9bOj+FjDiIHlcvIAISpPg2Vuq88gLp0HJ5W+A+sVirqmmCyU9GKeV5Faiv62CJy6ANCZ83GGX2rWcIAh1vGOQslMr9ay4Js+rJsVN4SIhCYdw9Em9hSpoZgimnOaszI7zn9EnPwVQgNETgVm7pAZdLkH5hxFoIKOPG2e79ZKKmzlkB/IZigoHZWNDUCFnEHDNFlTZjOEwoPi8DDGfzOEOGngWE7jmp24N7GzAP7e54Y3e48KtmIJ1/U0PFKOoi2Yv0Gh+E1siU5MBf8dLO7y7GafJWJ2oCUqJG0pLb2cgTf9pjkr625BV3XxODRylgqc5/UymTY6l1J0qO43u5hH3zaejng4I9cgieA3Y553rAEafAsfhrRmWsLW/kBdu4KLfY4eQ9z4B0TweW/xsofS0bkIqxalh9YuGBUsUhrwNUY7w6jgC6fjyMhtDdEHAlXC2fW1xLHEvY9CKojLNJQUnA0d5QCa22arI8IK63Jn8Cser9Cw57wOSSY0ruoJbctGdlsr/TySUkayAJJEmHjsH73OdbAztGuMjVq7Y643bTog4P3Zoysc="
    }
  }

  // DownloadPage: Page for downloading the Wikitude example at runtime. This is only required to retrieve
  // the Wikitude sources for the Felgo QML Live app, Wikitude sources can also be bundled with the app otherwise
  property Component downloadPage: Page {
    title: "AR Example - Download"
    Column {
      anchors.fill: parent
      anchors.margins: dp(12)
      spacing: dp(12)

      AppText {
        text: samplesDl.status === DownloadableResource.UnAvailable
              ? qsTr("Wikitude example requires to be downloaded (~ 2MB)")
              : samplesDl.status === DownloadableResource.Downloading
                ? qsTr("Downloading example... (%1%)").arg(samplesDl.progress)
                : qsTr("Extracting example... (%1%)").arg(samplesDl.progress)
        width: parent.width
      }

      AppButton {
        text: samplesDl.status === DownloadableResource.UnAvailable ? qsTr("Start download") : qsTr("Cancel download")
        onClicked: {
          if (samplesDl.status === DownloadableResource.UnAvailable) {
            samplesDl.download()
          } else {
            samplesDl.cancel()
          }
        }
      }

      ProgressBar {
        width: parent.width
        from: 0
        to: 100
        value: samplesDl.progress
      }
    }
  }

  // Component to download additional app resources, like the Wikitude example
  DownloadableResource {
    id: samplesDl
    source: "https://felgo.com/qml-sources/wikitude-examples/" + example + ".zip"
    extractAsPackage: true
    storageLocation: FileUtils.DownloadLocation
    storageName: example
    onDownloadFinished: {
      if (error === DownloadableResource.NoError) {
        navStack.clearAndPush(arPage) // Open AR page after download is finished
      }
    }
  }
}
