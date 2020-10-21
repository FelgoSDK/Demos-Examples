import QtQuick 2.0

Item {

  // prepareTracks - prepare track data for display in TracksPage

  function prepareTracks(tracks) {
    if(!dataModel.talks)
      return []

    var model = []
    for(var i in Object.keys(tracks)){
      var track = Object.keys(tracks)[i];
      var talks = []

      for(var j in Object.keys(dataModel.talks)) {
        var talkID = Object.keys(dataModel.talks)[j]
        var talk = dataModel.talks[parseInt(talkID)]

        if(talk !== undefined/* && talk.tracks.indexOf(track) > -1*/) {
          for(var idt in talk.tracks) {
            if(talk.tracks[idt].name == track) {
              talks.push(talk)
            }
          }
        }
      }
      var color = tracks[Object.keys(tracks)[i]]
      talks = prepareTrackTalks(talks)
      model.push({"title" : track, "talks" : talks, "color" : color})
    }
    model.sort(compareTitle)

    return model
  }

  // prepareTrackTalks - package talk data in array ready to be displayed by TimeTableDaySchedule item
  function prepareTrackTalks(trackTalks) {
    if(!trackTalks)
      return []

    var days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];

    // get events and prepare data for sorting and sections
    for(var idx in trackTalks) {
      var data = trackTalks[idx]

      // prepare event date for sorting
      var date = new Date(data.day)
      data.dayTime = date.getTime()

      // prepare event section
      var weekday = isNaN(date.getTime()) ? "Unknown" : days[ date.getDay() ]
      data.section = weekday + ", " + (data.start.substring(0, 2) + ":00")

      trackTalks[idx] = data
    }

    // sort events
    trackTalks = trackTalks.sort(function(a, b) {
      if(a.dayTime == b.dayTime)
        return (a.start > b.start) - (a.start < b.start)
      else
        return (a.dayTime > b.dayTime) - (a.dayTime < b.dayTime)
    })

    return trackTalks
  }

  // sort tracks by title
  function compareTitle(a,b) {
    if (a.title < b.title)
      return -1;
    if (a.title > b.title)
      return 1;
    return 0;
  }



  // prepareSpeakers - build speaker model for display
  function prepareSpeakers(speakers) {
    var model = []
    for(var i in Object.keys(speakers)){
      var speakerID = Object.keys(speakers)[i];
      var speaker = speakers[parseInt(speakerID)]
      if(!speaker["last_name"]) {
        speaker["last_name"] = speaker["first_name"].charAt(0).toUpperCase() + speaker["first_name"].slice(1)
        speaker["first_name"] = undefined
      }
      speaker["firstLetter"] = speaker["last_name"].charAt(0).toUpperCase()

      //console.log("\nSPEAKERS: "+JSON.stringify(speaker))
      if(speaker.talks.length > 0) model.push(speaker)
    }
    model.sort(compareLastName);
    return model
  }

  function compareLastName(a,b) {
    if (a.last_name < b.last_name)
      return -1;
    if (a.last_name > b.last_name)
      return 1;
    return 0;
  }
}
