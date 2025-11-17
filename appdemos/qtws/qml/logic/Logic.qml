import QtQuick

Item {

  signal initializeDataModel(var userStorageItem)

  signal increaseLocalAppStarts()

  signal loadData()

  signal setFeedBackSent(bool value)

  signal storeRating(int id, var rating)

  signal toggleFavorite(var item)

  signal clearCache()

  signal setNotificationsEnabled(bool value)

  // search - get talks with certain keyword in title or description
  function search(query) {
    var queryParts = query.toLowerCase().split(" ")
    var result = []

    // check talks
    for(var talkId in dataModel.talks) {
      var talk = dataModel.talks[talkId]
      var contains = 0

      // check query
      for (var queryPart of queryParts) {
        if(talk.title.toLowerCase().indexOf(queryPart) >= 0 ||
            talk.description.toLowerCase().indexOf(queryPart) >= 0) {
          contains++
        }

        for(var speakerId of talk.speakers) {
          var speaker = dataModel.speakers[speakerId]
          if(speaker.full_name.toLowerCase().indexOf(queryPart) >= 0) {
            contains++
          }
        }
      }

      if(contains === queryParts.length)
        result.push(talkId)
    } // check talks

    return result
  }
}
