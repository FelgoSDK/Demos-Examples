import QtQuick
import "../details"

Item {
  function prepareData(eventData) {
    let result = { speakers: {}, talks: {}, schedule: [], tracks: [] }

    result.talks = prepareTalks(eventData)
    result.speakers = prepareSpeakers(eventData, result.talks)
    result.schedule = prepareSchedule(result.talks)
    result.tracks = prepareTracks(result.talks)
    return result
  }

  function speakerTalksIds(speakerId, talks) {
    var speakerTalks = []
    if (talks !== undefined) {
      for (var talkId in talks) {
        if (talks[talkId]["speakers"] !== undefined) {
          if (talks[talkId]["speakers"].includes(speakerId)) {
            speakerTalks.push(talks[talkId]["id"])
          }
        }
      }
    }
    return speakerTalks
  }

  // prepareSpeakers - build speaker model for display
  function prepareSpeakers(data, talks) {
    var preparedSpeakers = {}
    for(var day in data.days) {
      for(var tracks in data.days[day]["tracks"]) {
        for(var events in data.days[day]["tracks"][tracks]["events"]) {
          for(var speakers in data.days[day]["tracks"][tracks]["events"][events]["speakers"]) {
            var speaker = data.days[day]["tracks"][tracks]["events"][events]["speakers"][speakers]
            var preparedSpeaker = speaker
            if (speaker["speaker_name"] === undefined) {
              continue
            }

            var speakerName = speaker["speaker_name"] //TODO: remove comma/whitespace etc.

            preparedSpeaker["id"] = speakerName
            preparedSpeaker["full_name"] = speakerName.split(",")[0]
            preparedSpeaker["first_name"] = preparedSpeaker["full_name"].split(" ")[0]
            preparedSpeaker["last_name"] = preparedSpeaker["full_name"].split(" ")[1]
            preparedSpeaker["title"] = speaker["occupation"]
            //preparedSpeaker["abstract"] = speaker["abstract"]
            preparedSpeaker["avatar"] = speaker["speaker_image"]["src"]
            preparedSpeaker["firstLetter"] = preparedSpeaker["first_name"].charAt(0).toUpperCase()
            preparedSpeaker["talks"] = speakerTalksIds(preparedSpeaker["id"], talks)

            preparedSpeakers[preparedSpeaker["id"]] = preparedSpeaker
          }
        }
      }
    }
    return preparedSpeakers;
  }

  // prepareTalks - build talks model for display
  function prepareTalks(data) {
    var preparedTalks = {}
    for(var day in data.days) {
      for(var tracks in data.days[day]["tracks"]) {
        for(var events in data.days[day]["tracks"][tracks]["events"]) {
          var event = data.days[day]["tracks"][tracks]["events"][events]

          // format start and end time
          let startDate = new Date(event["start_time"])
          let endDate = new Date(event["end_time"])
          event.start = startDate.toISOString()
          event.end = endDate.toISOString()

          // build talks model
          var preparedTalk = {}
          preparedTalk["id"] = event["event_title"]+"_"+event["start_time"] // Note: BREAK can occur multiple times, thus also include start_time
          preparedTalk["title"] = event["event_title"].replace(/^"+|^“+|"+$|”+$/g, '');
          preparedTalk["description"] = event["event_description"]
          preparedTalk["abstract"] = event["event_description"]

          if(event["event_color"] === "moss") {
            preparedTalk["color"] = "#878C7D"
            preparedTalk["tracks"] = "General Events"
            if(preparedTalk["description"] === "" || preparedTalk["description"] === undefined || preparedTalk["title"] === "Afterwork & Party") {
              preparedTalk["room"] = "Level B"
            }
            else {
              preparedTalk["room"] = "C01"
            }
          }
          else if(event["event_color"] === "pine") {
            preparedTalk["color"] = eventDetails.lemonColor
            preparedTalk["tracks"] = "Development Minds"
            preparedTalk["room"] = ["B05", "B07"]
          }
          else if(event["event_color"] === "neon") {
            preparedTalk["color"] = eventDetails.neonColor
            preparedTalk["tracks"] = "Qt Explorer"
            preparedTalk["room"] = ["B08", "B09"]
          }
          else if(event["event_color"] === "violet") {
            preparedTalk["color"] = eventDetails.violetColor
            preparedTalk["tracks"] = "Assure Quality"
            preparedTalk["room"] = ["A03", "A04"]
          }
          else if(event["event_color"] === "mandarin") {
            preparedTalk["color"] = eventDetails.mandarinColor
            preparedTalk["tracks"] = "HMI Creation / Design"
            preparedTalk["room"] = ["A05", "A06"]
          }
          else if(event["event_color"] === "blue") {
            preparedTalk["color"] = eventDetails.blueColor
            preparedTalk["tracks"] = "Academy"
            preparedTalk["room"] = "C01"
          }
          else if(event["event_color"] === "lemon") {
            preparedTalk["color"] = "#99A500"
            preparedTalk["tracks"] = "Keynotes & Customer Cases"
            preparedTalk["room"] = "C01"
          }

          preparedTalk["day"] = (event.start).substr(0, 10) // copy and make substring of year/month/day
          preparedTalk["start"] = calculateTimeAtEvent(event.start) // hour/minutes only
          preparedTalk["datetime"] = startDate
          preparedTalk["enddatetime"] = endDate
          preparedTalk["weekday"] = getWeekDay(preparedTalk["datetime"],  true)
          preparedTalk["date"] = preparedTalk.weekday
          preparedTalk["end"] = calculateTimeAtEvent(event.end) // hour/minutes only

          preparedTalk["speakers"] = []
          for(var speaker in event["speakers"]) {
            if ("speaker_name" in event["speakers"][speaker] && event["speakers"][speaker]["speaker_name"] !== undefined) {
              preparedTalk["speakers"].push(event["speakers"][speaker]["speaker_name"])
            }
          }

          preparedTalks[preparedTalk.id] = preparedTalk
        }
      }
    }
    return preparedTalks
  }

  // prepareSchedule - package schedule data in array with conference days (for tabs)
  function prepareSchedule(talks) {
    var model = {}

    for(var talkId in talks) {
      var talk = talks[talkId]

      var dateValue = talk.date
      if (!model[dateValue]) {
        var dayItem = {}
        dayItem["day"] = talk.day
        dayItem["weekday"] = talk.weekday
        dayItem["talks"] = []

        model[dateValue] = dayItem
      }

      model[dateValue].talks.push(talk.id)
    }

    return Object.keys(model).sort().map(dateValue => model[dateValue])
  }

  function prepareTracks(talks) {
    let tracks = {}
    for(var talkId in talks) {
      let event = talks[talkId]

//       build tracks model
      if(event["color"] !== undefined) {
        let trackName
        if(event["color"] === "#878C7D") {
          trackName = "General Events"
        }
        else if(event["color"] === eventDetails.lemonColor) {
          trackName = "Development Minds"
        }
        else if(event["color"] === eventDetails.neonColor) {
          trackName = "Qt Explorer"
        }
        else if(event["color"] === eventDetails.violetColor) {
          trackName = "Assure Quality"
        }
        else if(event["color"] === eventDetails.mandarinColor) {
          trackName = "HMI Creation / Design"
        }
        else if(event["color"] === eventDetails.blueColor) {
          trackName = "Academy"
        }
        else if(event["color"] === "#99A500") {
          trackName = "Keynotes & Customer Cases"
        }
        if(!tracks[trackName]) {
          tracks[trackName] = {
            "title": trackName,
            "color": event["color"],
            "talks": []
          }
        }
        tracks[trackName].talks.push(event.id)
      }
    }
    return Object.keys(tracks).map(trackId => tracks[trackId])
  }

  // format2DigitTime - adds leading zero to time (hour, minute) if required
  function format2DigitTime(time) {
    return (("" + time).length < 2) ? "0" + time : time
  }

  function getWeekDay(datetime, longFormat = false) {
    var days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    if(longFormat) {
      days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
    }

    return days[ datetime.getUTCDay() ]
  }

  function calculateTimeAtEvent(startDateStr) {
    let hour = Number(startDateStr.substr(11,2)) + eventDetails.timeZoneOffset
    let minuteStr = startDateStr.substr(14,2)
    return format2DigitTime(hour) + ":" + minuteStr
  }
}
