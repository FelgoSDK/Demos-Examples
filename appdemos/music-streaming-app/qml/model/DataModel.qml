import Felgo 4.0
import QtQuick 2.0


JsonListModel {
  id: root

  property var dataSource: [
    {
      "type": "Artist",
      "name": "Maki",
      "image": "../../assets/covers/food.jpg"
    },
    {
      "type": "Artist",
      "name": "Silent Rafter",
      "image": "../../assets/covers/raft.jpg"
    },
    {
      "type": "Artist",
      "name": "Fango",
      "image": "../../assets/covers/disco.jpg"
    },
    {
      "type": "Artist",
      "name": "Diego",
      "image": "../../assets/covers/podcast.jpg"
    },
    {
      "type": "Artist",
      "name": "Gumbar",
      "image": "../../assets/covers/love.jpg"
    },
    {
      "type": "Artist",
      "name": "Da.G",
      "image": "../../assets/covers/hiphop.jpg"
    },
    {
      "type": "Album",
      "name": "Fat Belly",
      "author": "Maki",
      "image": "../../assets/covers/food.jpg"
    },
    {
      "type": "Album",
      "name": "Mhmkay",
      "author": "Da.G",
      "image": "../../assets/covers/hiphop.jpg"
    },
    {
      "type": "Album",
      "name": "Party Time",
      "author": "Fango",
      "image": "../../assets/covers/disco.jpg"
    },
    {
      "type": "Album",
      "name": "Drumby",
      "author": "Gumbar",
      "image": "../../assets/covers/love.jpg"
    },
    {
      "type": "Album",
      "name": "LIQUID",
      "author": "Silent Rafter",
      "image": "../../assets/covers/raft.jpg"
    },
    {
      "type": "Song",
      "name": "Camping with the bears",
      "album": "LIQUID",
      "tags": ["Eletric", "Gaming"],
      "image": "../../assets/covers/raft.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#429a9e",
      "duration": "205000"
    },
    {
      "type": "Song",
      "name": "Mhmkay",
      "album": "Mhmkay",
      "tags": ["Hip-Hop"],
      "image": "../../assets/covers/hiphop.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#429a9e",
      "duration": "205000"
    },
    {
      "type": "Song",
      "name": "Woke at the lake",
      "album": "LIQUID",
      "tags": ["Eletric", "Gaming"],
      "image": "../../assets/covers/raft.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#429a9e",
      "duration": "205000"
    },
    {
      "type": "Song",
      "name": "Chilly winter",
      "album": "Drumby",
      "tags": ["Pop", "Chill"],
      "image": "../../assets/covers/love.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#429a9e",
      "duration": "204000"
    },
    {
      "type": "Song",
      "name": "Mighty lion's roar",
      "album": "Drumby",
      "tags": ["Party", "Pop"],
      "image": "../../assets/covers/love.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#c9a355",
      "duration": "176000"
    },
    {
      "type": "Song",
      "name": "The burger song",
      "album": "Fat Belly",
      "tags": ["Entertainment", "Hip-Hop"],
      "image": "../../assets/covers/food.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#445c94",
      "duration": "175000"
    },
    {
      "type": "Song",
      "name": "Future Remix",
      "album": "Party Time",
      "tags": ["Party"],
      "image": "../../assets/covers/disco.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#445c94",
      "duration": "175000"
    },
    {
      "type": "Song",
      "name": "Happy Day",
      "album": "Party Time",
      "tags": ["Party"],
      "image": "../../assets/covers/disco.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "color": "#445c94",
      "duration": "175000"
    },
    {
      "type": "Podcast",
      "name": "10% time, 200% fun",
      "author": "Diego",
      "tags": ["Motivation", "Podcast"],
      "image": "../../assets/covers/podcast.jpg",
      "pathToTrack": "../../assets/freesound-org--rock-music-publicdomain.mp3",
      "duration": "195000"
    }
  ]

  fields: [
    "type",
    "name",
    "author",
    "album",
    "image",
    "tags",
    "pathToTrack"
  ]

  source: dataSource

  function findAndGetFieldValue(name, field) {

    for (const entry of root.source) {
      if (entry["name"] === name) {
        return entry[field]
      }
    }

    return ""
  }

  function getByName(name) {
    for (const entry of root.source) {
      if (entry["name"] === name) {
        return entry
      }
    }

    return null
  }

  // hasReference is used to indicate if term can be found amoung values in JS object (entry)
  function hasReference(entry, term) {

    if (!entry || entry === undefined) {
      return false
    }

    for (const field in entry) {

      var type = typeof entry[field]
      if (type === "string") {

        var value = entry[field].toLowerCase()
        if (value.startsWith(term.toLowerCase())) {
          return true
        }
      } else if (type === "object") {

        for (const value of entry[field]) {
          if (value.toLowerCase().startsWith(term.toLowerCase())) {
            return true
          }
        }
      }
    }

    // for songs we additionally check if it's album or author fit term
    if (entry["type"] === "Song") {
      console.log(entry.name + " - " + entry["album"])

      // we also check if songs are not in the same album
      if (findAndGetFieldValue(term, "album") === entry["album"] && entry["album"] !== undefined) {
        return true
      }

      if (hasReference(getByName(entry["album"]), term)) {
        return true
      } else {
        return hasReference(getByName(entry["author"]), term)
      }
    }

    return false
  }

  // buildModelUponSearch cleans model and adds these entries which have references to search request
  function buildModelUponSearch(term="") {
    root.remove(0, root.count)

    for (const entry of root.dataSource) {

      if (hasReference(entry, term)) {
        root.append(entry)
      }
    }
  }

  function isFavorite(entry) {
    if (entry === undefined) {
      return false
    }

    var favorites = storage.getValue("favorites")
    if (favorites === undefined) {
      console.log("favorites are undefined")
      storage.setValue("favorites", [])
      return false
    }

    for (const f of favorites) {
      if (entry["name"] === f) {
        return true
      }
    }

    return false
  }

  function addToFavorites(entry) {
    var favorites = storage.getValue("favorites")
    if (favorites === undefined) {
      favorites = []
    }

    if (!isFavorite(entry)) {
      favorites.push(entry["name"])
    }

    storage.setValue("favorites", favorites)
  }

  function removeFromFavorites(entry) {
    var favorites = storage.getValue("favorites")
    if (favorites === undefined) {
      favorites = []
    }

    var index = favorites.indexOf(entry["name"])
    favorites.splice(index, 1);

    storage.setValue("favorites", favorites)
  }

  // relatedTracks function returns list of playable tracks related to passed entry
  function relatedTracks(entry) {
    var tracks = []

    for (const track of root.dataSource) {

      if (hasReference(track, entry["name"])) {
        if (track["type"] === "Song" || track["type"] === "Podcast") {
          tracks.push(track)
        }
      }
    }

    return tracks
  }

  function showFavorites() {
    root.remove(0, root.count)

    var favorites = storage.getValue("favorites")
    if (favorites === undefined) {
      console.log("Favorites are unspecified")
      return
    }

    for (const entry of root.dataSource) {

      if (isFavorite(entry)) {
        root.append(entry)
      }
    }
  }

  function getCover(entry) {
    if (entry === undefined) {
      return ""
    }

    if (entry.type === "Song") {
      if (entry.image !== "" && entry.image !== undefined) {
        return Qt.resolvedUrl(entry.image)
      }

      if (entry.album !== "" && entry.album !== undefined) {
        return root.findAndGetFieldValue(entry.album, "image")
      } else if (entry.author !== "" && entry.author !== undefined) {
        return root.findAndGetFieldValue(entry.author, "image")
      }

      return "" // put same placeholder here
    }

    return Qt.resolvedUrl(entry.image)
  }
}
