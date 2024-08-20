import QtQuick 2.0
import QtQuick.Controls 2.0
import Felgo 4.0


App {

  Component.onCompleted: {
    // Remove activation delay to immediately show the indicator for requests.
    // Otherwise, requests that take less than the default 150 ms won't trigger the indicator.
    HttpNetworkActivityIndicator.activationDelay = 0

    // Configure caching
    HttpRequest.config({
                         cache: { maxSize: 20000 } // max size of 200000 bytes
                       })
  }

  NavigationStack {
    AppPage {
      id: myPage
      title: "HttpRequest Example"
      rightBarItem: ActivityIndicatorBarItem {
        animating: HttpNetworkActivityIndicator.enabled
        visible: animating
      }

      // HttpNetworkActivityIndicator is not supported with Promises.
      // This example thus uses a custom activity indicator handling.
      property bool promisePending: false

      // Function to send all requests and handle the result
      function sendAllRequests() {
        // Trigger first request
        var p1 = HttpRequest
        .get("https://jsonplaceholder.typicode.com/todos/1")
        .cacheSave(false) // do not save response of first request to cache
        .cacheLoad(HttpCacheControl.AlwaysNetwork) // always load from network
        .then(function(res){ return res.body })

        // Trigger second request
        var p2 = HttpRequest
        .get("https://jsonplaceholder.typicode.com/posts/1")
        .timeout(5000)
        .cacheLoad(HttpCacheControl.PreferCache) // use cache if possible, otherwise load from network
        .then(function(res){ return res.body })

        // Create promise to check success of both requests
        var allRequests = Promise.all([p1, p2])

        // Handle promise result
        allRequests.then(function(values) {
          var time = new Date().toLocaleString()
          const result = "<b>Both requests finished at " + time + "</b>: " + JSON.stringify(values)
          console.log(result)
          output.append(result)
        }).catch(function (err) {
          console.error("Error: " + err)
        })
      }

      Column {
        anchors.centerIn: parent
        spacing: dp(10)

        AppButton {
          text: "Send Get Requests"
          onClicked: myPage.sendAllRequests()
        }

        AppFlickable {
          id: flick
          width: myPage.width * 0.8
          height: myPage.height / 2
          contentWidth: output.paintedWidth
          contentHeight: output.paintedHeight
          clip: true

          AppTextEdit {
            id: output
            width: flick.width
            height: flick.height
            readOnly: true
            wrapMode: Text.WordWrap
            textFormat: TextEdit.RichText
            placeholderText: "Log messages on HttpRequest will be shown here"
          }
          ScrollBar.vertical: ScrollBar { }
        }
      }
    }
  }
}
