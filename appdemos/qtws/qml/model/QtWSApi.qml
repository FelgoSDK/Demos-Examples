import Felgo
import QtQuick

QtObject {
  id: _

  // url of locally stored event data in assets
  readonly property string fallbackScheduleUrl: Qt.resolvedUrl("../../assets/data/data.json")

  property bool loading: false

  Component.onCompleted: {
    HttpNetworkActivityIndicator.activationDelay = 0
  }

  signal eventDataLoaded(var eventData)

  // sendGetRequest - load data from url with success handler
  function sendGetRequest(url, successHandler, errorHandler) {
    // prepare and send request
    HttpRequest
    .get(url)
    .set("Accept", 'application/json')
    .then(function(res) {
      loading = false
      successHandler(JSON.parse(res.text))
    })
    .catch(function(err) {
      loading = false
      console.warn(JSON.stringify(err))
      console.error("Error: Failed to load data from "+url+", error = "+err.message)
      if(errorHandler !== undefined)
        errorHandler()
      else
        dataModel.loadingFailed()
    })
    loading = true
  }

  // loadData - loads event data from API
  function loadData() {
    _.sendGetRequest(_.fallbackScheduleUrl , function(eventData) {
      dataModel.eventData = eventData
      localStorage.setValue("eventData", dataModel.eventData)
      eventDataLoaded(eventData)
    }, function() {
      // error handler
      dataModel.loadingFailed()
    })
  }
}
