import QtQuick 2.0
import Felgo 4.0

Item {
  id: root

  readonly property var dataSource: dataModel.dataSource

  property alias recentlyPlayedModel: recentlyPlayedModel
  property alias madeForYouModel: madeForYouModel
  property alias popularModel: popularModel
  property alias popSongsModel: popSongsModel
  property alias podcastsToTryModel: podcastsToTryModel

  JsonListModel {
    id: recentlyPlayedModel

    function prepare() {
      var recentlyPlayed = storage.getValue("recentlyPlayed")
      recentlyPlayedModel.source = recentlyPlayed === undefined ? [] : recentlyPlayed
    }
  }

  JsonListModel {
    id: madeForYouModel

    function prepare() {
      madeForYouModel.clear()

      var max = 5
      var dataSourceCopy = root.dataSource
      dataSourceCopy = shuffle(dataSourceCopy)

      // get first five randomized songs
      for (const entry of dataSourceCopy) {
        if (madeForYouModel.count >= max) {
          return
        }

        if (entry.type === "Song") {
          madeForYouModel.append(entry)
        }
      }
    }
  }

  JsonListModel {
    id: popularModel

    function prepare() {
      popularModel.clear()

      var max = 5
      var dataSourceCopy = root.dataSource
      dataSourceCopy = shuffle(dataSourceCopy)

      // get first five randomized songs
      for (const entry of dataSourceCopy) {
        if (popularModel.count >= max) {
          return
        }

        if (entry.type === "Song") {
          popularModel.append(entry)
        }
      }
    }
  }

  JsonListModel {
    id: popSongsModel

    function prepare() {
      popSongsModel.clear()

      // get all pop songs
      for (const entry of root.dataSource) {
        if (entry.type === "Song" && entry.tags !== undefined) {
          if (entry.tags.includes("Pop")) {
            popSongsModel.append(entry)
          }
        }
      }
    }
  }

  JsonListModel {
    id: podcastsToTryModel

    function prepare() {
      podcastsToTryModel.clear()

      // get all podcasts
      for (const entry of root.dataSource) {
        if (entry.type === "Podcast") {
          podcastsToTryModel.append(entry)
        }
      }
    }
  }

  // Fisher-Yates (aka Knuth) Shuffle to get randomized array
  function shuffle(array) {
    var currentIndex = array.length, temporaryValue, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;

      // And swap it with the current element.
      temporaryValue = array[currentIndex];
      array[currentIndex] = array[randomIndex];
      array[randomIndex] = temporaryValue;
    }

    return array;
  }

  Component.onCompleted: {
    recentlyPlayedModel.prepare()
    madeForYouModel.prepare()
    popularModel.prepare()
    popSongsModel.prepare()
    podcastsToTryModel.prepare()
  }
}
