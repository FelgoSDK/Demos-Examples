import Felgo 4.0
import QtQuick 2.0


App {
  Component.onCompleted: {
    HttpRequest
    .get("https://httpbin.org/get")
    .timeout(5000)
    .then(function(res) {
      var result = "HttpRequest response: " + res.status
          + "\nHEADER: " + JSON.stringify(res.header, null, 4)
          + "\nBODY: " + JSON.stringify(res.body, null, 4)
      textEdit.text = result
    })
    .catch(function(err) {
      console.log(err.message)
      console.log(err.response)
    });
  }

  NavigationStack {
    AppPage {
      title: "HttpRequest"

      AppFlickable {
        id: flick
        anchors {
          fill: parent
          margins: dp(20)
        }
        contentWidth: textEdit.paintedWidth
        contentHeight: textEdit.paintedHeight
        clip: true

        AppTextEdit {
          id: textEdit
          width: parent.width
          height: parent.height
          font.pixelSize: 10
          readOnly: true
          placeholderText: "Log messages on HttpRequest will be shown here"
        }
      }
    }
  }
}
