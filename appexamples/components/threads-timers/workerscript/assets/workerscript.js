// Helper function to format parameters in get query
function formatParams(params){
  return "?" + Object.keys(params).map(function(key) {
    return key + "=" + encodeURIComponent(params[key])
  } ).join("&")
}

// Main function to prepare parameters for query, send it, got response
function doRequest(date, years, months, days) {
  let endpoint = "https://postman-echo.com/time/subtract"
  let params = {
    timestamp: date,
    years: years,
    months: months,
    days: days
  }
  const url = endpoint + formatParams(params)
  console.warn("Sending query: ", url)

  let xhr = new XMLHttpRequest();
  xhr.open('GET', url, false);

  try {
    xhr.send();
    if (xhr.status !== 200) {
      console.error("Error: ", xhr.status, xhr.responseText)
      return { error: "Error " + xhr.status }
    } else {
      return xhr.response;
    }
  } catch(err) {
    return { error: "Request failed" }
  }
}


// Call from QML side. All parameters are stored in message
WorkerScript.onMessage = function(message) {
  var queryResult = doRequest(message.baseDate, message.years, message.months, message.days)
  // Send result back to main thread
  WorkerScript.sendMessage( { result: queryResult } )
}
