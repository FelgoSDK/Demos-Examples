import Felgo
import QtQuick
import "../common"
import "."

Item {
  id: dataModel

  // property to configure target dispatcher / logic
  property alias dispatcher: logicConnection.target

  // processed data for UI
  property var speakers: undefined
  property var talks: undefined
  property var schedule: undefined
  property var tracks: undefined

  // local storage data
  property var eventData

  property int localAppStarts: 0
  property bool feedBackSent: false
  property bool notificationsEnabled: true

  // user storage data
  property var favorites: undefined
  property var userStorage: undefined // reference to user storage for favorites

  readonly property alias loading: api.loading
  readonly property bool loaded: !!speakers && !!talks

  property bool initialized: false

  onNotificationsEnabledChanged: localStorage.setValue("notificationsEnabled", notificationsEnabled)
  onTalksChanged: {
    // need to update when new talk data arrives
    dataModel.favoritesChanged()
  }

  signal loadingFailed()
  signal favoriteAdded(var talk)
  signal favoriteRemoved(var talk)

  function loadStorageApiData() {
    let eventData = localStorage.getValue("eventData") || {}
    let viewData = viewHelper.prepareData(eventData)

    dataModel.talks = viewData.talks
    dataModel.speakers = viewData.speakers
    dataModel.schedule = viewData.schedule
    dataModel.tracks = viewData.tracks
  }

  Connections {
    id: logicConnection

    // action 1 - get data from local storage
    function onInitializeDataModel(userStorageItem) {
      // setup
      dataModel.userStorage = userStorageItem

      // get favorites from user storage
      dataModel.favorites = userStorage.getValue("favorites")

      // load local storage
      dataModel.notificationsEnabled = localStorage.getValue("notificationsEnabled") !== undefined ? localStorage.getValue("notificationsEnabled") : true

      dataModel.localAppStarts = localStorage.getValue("localAppStarts") || 0
      dataModel.feedBackSent = localStorage.getValue("feedBackSent") || false

      dataModel.initialized = true

      loadStorageApiData()
    }

    // action 2 - increaseLocalAppStarts - increase local app start counter
    function onIncreaseLocalAppStarts() {
      if(!initialized)
        return

      localAppStarts++
      localStorage.setValue("localAppStarts",localAppStarts)
    }

    // action 3 - loadData - fetches all data from Qt WS api
    function onLoadData() {
      if(initialized && !loading) {
        api.loadData() // checks version and loads data if necessary
      }
    }

    // action 5 - setFeedBackSent - store whether feedback was sent
    function onSetFeedBackSent(value) {
      if(!initialized)
        return

      feedBackSent = !!value  // ensures boolean type
      localStorage.setValue("feedBackSent", feedBackSent)
    }

    // action 6 - storeRating
    function onStoreRating() {
      if(!ratings) ratings = {}
      ratings[id] = rating
      localStorage.setValue("ratings", ratings)
    }

    // action 7 - toggleFavorite - add or remove item from favorites
    function onToggleFavorite(item) {
      if(dataModel.favorites === undefined)
        dataModel.favorites = { }

      if(dataModel.favorites[item.id]) {
        delete dataModel.favorites[item.id]
        dataModel.favoriteRemoved(item)
      }
      else {
        dataModel.favorites[item.id] = item.id
        dataModel.favoriteAdded(item)
      }

      // store favorites
      userStorage.setValue("favorites", dataModel.favorites)
      // call the changed here, to schedule the notifications with the new local data
      favoritesChanged()
    }

    // action 11 - clears locally stored data
    function onClearCache() {
      // reset dataModel, but keep favorites and contacts
      var favorites = dataModel.favorites
      _.reset()
      dataModel.favorites = favorites

      // clear local storage, favorites and contacts are still in user storage
      localStorage.clearAll()
      initialized = true // also reloads api data after reset
    }

    // action 12 - setNotificationsEnabled
    function onSetNotificationsEnabled() {
      notificationsEnabled = value
    }
  }

  // api for data access
  QtWSApi {
    id: api
    onEventDataLoaded: eventData => {
                         let viewData = viewHelper.prepareData(eventData)
                         dataModel.talks = viewData.talks
                         dataModel.speakers = viewData.speakers
                         dataModel.schedule = viewData.schedule
                         dataModel.tracks = viewData.tracks
                      }
  }

  // storage for caching data
  Storage {
    id: localStorage
    databaseName: "localStorage"
  }

  // private
  Item {
    id: _

    // reset data model
    function reset() {
      dataModel.initialized = false

      dataModel.eventData = undefined

      dataModel.speakers = undefined
      dataModel.talks = undefined
      dataModel.tracks = undefined
      dataModel.schedule = undefined

      dataModel.favorites = undefined
      dataModel.notificationsEnabled = true

      localAppStarts = 0
      feedBackSent = false
    }
  }

  // isFavorite - check if item is favorited
  function isFavorite(id) {
    return dataModel.favorites !== undefined && dataModel.favorites[id] !== undefined
  }
}
