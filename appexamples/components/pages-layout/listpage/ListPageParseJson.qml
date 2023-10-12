import Felgo 3.0
import QtQuick 2.0


App {
  id: app
  // Property will store data
  property var jsonData: null

  // Load the data when the component was successfully created
  Component.onCompleted: {
    loadJsonData()
  }

  NavigationStack {
    // Display the JSON data in a list
    ListPage {
      id: page
      title: "Parse JSON"
      model: app.jsonData
    }
  }

  // Use XMLHttpRequest object to dynamically load data from a file or web service
  function loadJsonData() {
    var xhr = new XMLHttpRequest
    xhr.onreadystatechange = function() {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        var dataString = xhr.responseText
        app.jsonData = JSON.parse(dataString)
      }
    }
    xhr.open("GET", "assets/data.json")
    xhr.send()
  }
}
