import QtQuick 2.0
import Felgo 3.0

Item {
  function sendRequest(category, callback) {
    var method = "GET"
    var url = "https://raw.githubusercontent.com/SauravKanchan/NewsAPI/master/top-headlines/category/" + category + "/us.json"
    console.debug(method + ": " + url)

    HttpRequest.get(url)
    .then(function(res) {
      var content = res.text
      try {
        var obj = JSON.parse(content)
      }
      catch (ex) {
        console.error("Could not parse JSON: ", ex)
        return
      }
      console.debug("Success parsing JSON")
      callback(obj)
    })
    .catch(function(err) {
      console.debug("Fatal error in URL GET", err)
    })
  }
}
