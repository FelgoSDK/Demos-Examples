function formatTime(seconds) {
  var hours = Math.floor(seconds / 3600)
  seconds %= 3600
  var minutes = Math.floor(seconds / 60)
  minutes = String(minutes).length > 1 ? minutes : "0" + minutes
  seconds = seconds % 60
  seconds = String(seconds).length > 1 ? seconds : "0" + seconds

  return hours + ":" + minutes + ":" + seconds
}

function averageSpeed(distance, timePassed) {
  const timePassedAsHours = timePassed / 3600

  if (timePassedAsHours === 0) {
    return "-/- km/h"
  }

  return (distance / timePassedAsHours).toFixed(1) + " km/h"
}
