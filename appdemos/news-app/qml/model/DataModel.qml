import QtQuick
import Felgo
import Qt.labs.settings

Item {
  readonly property color backgroundColor: darkMode ? "#262626" : "white"
  readonly property color redColor: darkMode ? "#d40000" : "red"
  readonly property color articleTextColor: darkMode ? "gainsboro" : "2b2b21"

  signal articlesReceived

  property alias dispatcher: logicConnection.target
  property var articles
  property bool darkMode: false

  Client {
    id: client
  }

  Connections {
    id: logicConnection
  }

  function createModelForCategory(category, callback) {
    client.sendRequest(category, function(result) {
      callback(_.createArticlesModel(result["articles"]))
    })

  }

  Item {
    id: _

    property var articles

    function responseCallback(obj) {
      var response = obj.response
      var code = response.application_response_code
      console.debug("Server returned app code: ", code)
    }

    function createArticlesModel(source, parseValues) {
      console.log("creating the model")
      return source.map(function(data) {
        if (parseValues) {
          data = JSON.parse(data)
        }

        return {
          articleTitle: data.title,
          detailText: data.description,
          image: data.urlToImage,
          model: data,
          shareUrl: data.url
        }
      })
    }
  }
}
