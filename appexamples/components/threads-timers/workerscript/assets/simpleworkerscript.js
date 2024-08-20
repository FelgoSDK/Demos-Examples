// Main function to prepare parameters for query, send it, got response
function doCalculation(number) {
  // Here could be long lasting operation
  return number*number
}


// Call from QML side. All parameters are stored in message
WorkerScript.onMessage = function(message) {
  const calculationResult = doCalculation(message.number)

  // Send result back to main thread
  WorkerScript.sendMessage( { result: calculationResult } )
}
