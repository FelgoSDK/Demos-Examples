import QtQuick
import Felgo
import Qt5Compat.GraphicalEffects
import "logic"
import "pages"
import "common"
import "details"

Item {
  anchors.fill: parent

  // make navigation public
  property alias navigation: navigation

  Component.onCompleted: {
    notificationTimer.start() // schedule notification at app-start
  }

  // handle data loading failed
  Connections {
    target: dataModel
    function onLoadingFailed() {
      NativeDialog.confirm("Failed to update conference data, please try again later.")
    }

    function onFavoriteAdded(talk) {
      console.debug("favorite added")

      // only schedule a notification for the changed talk, not for all again
      scheduleNotificationForTalk(talk.id)
    }

    function onFavoriteRemoved(talk) {
      console.debug("favorite removed")

      cancelNotificationForTalk(talk.id)
    }

    function onNotificationsEnabledChanged() {
      console.debug("onNotificationsEnabledChanged, reschedule notifications")
      scheduleNotifications()
    }
  }

  // timer to schedule notifications several seconds after app startup
  Timer {
    id: notificationTimer
    interval: 8000 // we can delay this, is not time-critical to happen initially
    onTriggered: {
      console.debug("notificationTimer.triggered", running)
      scheduleNotifications()
    }
  }

  function scheduleNotifications() {
    console.debug("attempting scheduleNotifications()")

    if(notificationTimer.running) {
      console.debug("notificationTimer at initialization is currently running, dont update yet")
      return
    }

    // if used within Demo Launcher app project, we do not use notifications
    if(typeof notificationManager === "undefined")
      return

    console.debug("scheduling notifications now")

    notificationManager.cancelAllNotifications()
    if(!dataModel.notificationsEnabled)
      return

    scheduleNotificationsForConferenceStart()
    scheduleNotificationsForFavorites()
  }

  function scheduleNotificationsForConferenceStart() {
    var nowTime = Date.now()

    // get start date and change hour to 9 pm (event time)
    var eveningBeforeConferenceDatetime = eventDetails.startDate
    let currOffset = eveningBeforeConferenceDatetime.getTimezoneOffset()
    eveningBeforeConferenceDatetime.setHours(21 - Math.floor((currOffset / 60)) - eventDetails.timeZoneOffset)
    eveningBeforeConferenceDatetime.setMinutes(0)
    eveningBeforeConferenceDatetime.setSeconds(0)
    eveningBeforeConferenceDatetime.setMilliseconds(0)

    // go back by a day
    eveningBeforeConferenceDatetime.setTime(eveningBeforeConferenceDatetime.getTime() - (24 * 60 * 60 * 1000))
    var eveningBeforeConferenceTime = eveningBeforeConferenceDatetime.getTime()

    if(nowTime < eveningBeforeConferenceTime) {
      var text = "Felgo wishes all the best for " + eventDetails.name + "!"
      var notification = {
        notificationId: -1,
        message: text,
        timestamp: Math.round(eveningBeforeConferenceTime / 1000) // utc seconds
      }
      var result = notificationManager.schedule(notification)
      console.log("result", result)
    }
  }

  function scheduleNotificationsForFavorites() {
    if(!dataModel.favorites || !dataModel.talks)
      return

    for(var idx in dataModel.favorites) {
      var talkId = dataModel.favorites[idx]
      scheduleNotificationForTalk(talkId)
    }
  }

  function scheduleNotificationForTalk(talkId) {
    if(dataModel.loaded && dataModel.talks && dataModel.talks[talkId]) {
      var talk = dataModel.talks[talkId]
      var text = talk.title+" starts at "+talk.start +" at "+talk.room+"."

      var nowTime = Date.now()
      var notificationTime = talk.datetime.getTime() - (10 * 60 * 1000) // 10 minutes before

      if (nowTime < notificationTime) {
        var notification = {
          notificationId: talkId,
          message: text,
          timestamp: Math.round(notificationTime / 1000) // utc seconds
        }
        notificationManager.schedule(notification)
      }
    }
  }

  function cancelNotificationForTalk(talkId) {
    notificationManager.cancelNotification(talkId)
  }

  Timer {
    id: indexTimer
    interval: 200
    onTriggered: navigation.latestIndex = navigation.currentIndex
  }

  LinearGradient {
    visible: !(app.tablet || Theme.isAndroid)
    width: parent.width
    height: appDetails.darkMode ? dp(12) : Theme.isAndroid ? dp(5) : dp(8)
    anchors.bottom: parent.bottom
    anchors.bottomMargin: dp(Theme.navigationTabBar.height) + NativeUtils.safeAreaInsets.bottom
    opacity: appDetails.darkMode ? 0.15 : Theme.isAndroid ? 0.15 : 0.05
    z: 1
    gradient: Gradient {
      GradientStop { position: 0.0; color: "#00000000" }
      GradientStop { position: 1.0; color: "black" }
    }
  }

  LinearGradient {
    visible: app.tablet
    width: appDetails.darkMode ? dp(12) : Theme.isAndroid ? dp(5) : dp(8)
    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: navigation.drawer.width + NativeUtils.safeAreaInsets.left
    opacity: appDetails.darkMode ? 0.25 : Theme.isAndroid ? 0.15 : 0.10
    z: 1
    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 1.0; color: "#00000000" }
      GradientStop { position: 0.0; color: "black" }
    }
  }

  // app navigation
  Navigation {
    id: navigation
    navigationMode: app.tablet || Theme.isAndroid ? navigationModeDrawer : navigationModeTabs
    drawerFixed: app.tablet
    drawerInline: app.tablet
    drawerLogoSource: Qt.resolvedUrl("../assets/big-logo.png")
    drawerLogoHeight: dp(100)
    drawerLogoBackgroundColor: eventDetails.pineColor

    property int latestIndex

    // automatically load data if not loaded and schedule/favorites page is opened
    onCurrentIndexChanged: {
      if(currentIndex > 0 && currentIndex <= 3) {
        if(!dataModel.loaded && isOnline)
          logic.loadData()
      }
      indexTimer.start()
    }

    NavigationItem {
      title: "Home"

      iconComponent: Component {
        Item {
          height: !!parent ? parent.height : 0
          width: height

          property bool selected: parent && parent.selected

          AppIcon {
            anchors.centerIn: parent
            width: height
            height: parent.height
            iconType: IconType.home
            color: !parent.selected ? Theme.textColor  : Theme.tintColor
            visible: !qtIcon.visible
          }

          Image {
            id: qtIcon
            height: parent.height
            anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
            fillMode: Image.PreserveAspectFit
            source: (Theme.isAndroid ? "../assets/qt-button-black.png" : "../assets/qt-button-gray.png")
            visible: true
          }

          ColorOverlay {
              anchors.fill: qtIcon
              source: qtIcon
              color: parent.selected ? Theme.navigationTabBar.titleColor : Theme.navigationTabBar.titleOffColor
          }
        }
      }

      NavigationStack {
        navigationBarShadow: false
        navigationBar.dividerColor: "transparent"
        MainPage {
          id: mainPage
        }
      }
    } // main

    NavigationItem {
      title: "Agenda"
      iconType: IconType.calendaro

      NavigationStack {
        splitView: tablet && landscape

        TimetablePage {
          id: agendaPage
        }
      }
    } // timetable

    NavigationItem {
      title: "Favorites"
      iconType: IconType.star
      Loader { sourceComponent: favoritesComponent }
    } // favorites

    NavigationItem {
      title: "Tracks"
      iconType: IconType.road
      Loader { sourceComponent: tracksComponent }
    } // tracks

    NavigationItem {
      title: "Venue"
      iconType: IconType.building
      showItem: app.tablet
      Loader { sourceComponent: venueComponent }
    } // venue

    NavigationItem {
      title: "Speakers"
      iconType: IconType.microphone
      showItem: app.tablet
      Loader { sourceComponent: speakersComponent }
    } // speakers

    NavigationItem {
      title: "Settings"
      iconType: IconType.gears
      showItem: app.tablet
      Loader { sourceComponent: settingsComponent }
    } // settings

    NavigationItem {
      title: "More"
      iconType: IconType.ellipsish
      showItem: true
      Loader { sourceComponent: moreComponent }
    } // more

    NavigationItem {
      title: "About this app"
      showItem: false
      iconComponent: Item {
        height: parent.height
        width: height

        property bool selected: parent && parent.selected

        AppIcon {
          anchors.centerIn: parent
          width: height
          height: parent.height
          iconType: IconType.home
          color: parent.selected ? Theme.navigationTabBar.titleColor : Theme.navigationTabBar.titleOffColor
          visible: !felgoIcon.visible
        }

        Image {
          id: felgoIcon
          height: parent.height
          anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
          fillMode: Image.PreserveAspectFit
          source: !parent.selected ? "../assets/Felgo_icon_nav_off.png" : "../assets/Felgo_icon_nav.png"
          visible: true
        }

        ColorOverlay {
            anchors.fill: felgoIcon
            source: felgoIcon
            color: parent.selected ? Theme.navigationTabBar.titleColor : Theme.navigationTabBar.titleOffColor
        }
      }
      Loader { sourceComponent: aboutFelgoComponent }
    } // About Felgo
  } // nav

  Component {
    id: favoritesComponent
    NavigationStack {
      splitView: tablet && landscape
      FavoritesPage {
        id: favoritesPage
      }
    }
  }

  Component {
    id: speakersComponent
    NavigationStack {
      splitView: landscape && tablet
      SpeakersPage {

      }
    }
  }

  Component {
    id: moreComponent
    NavigationStack {
      splitView: tablet && landscape
      Component.onCompleted: push(Qt.resolvedUrl("pages/MorePage.qml"))
    }
  }

  Component {
    id: tracksComponent
    NavigationStack {
      splitView: landscape && tablet
      TracksPage {
        id: tracksPage
      }
    }
  }

  Component {
    id: venueComponent
    NavigationStack {
      VenuePage {

      }
    }
  }

  Component {
    id: settingsComponent
    NavigationStack {
      SettingsPage {

      }
    }
  }

  Component {
    id: aboutFelgoComponent
    NavigationStack {
      Component.onCompleted: push(Qt.resolvedUrl("pages/AboutFelgoPage.qml"))
    }
  }

  Component {
    id: searchPageComponent
    SearchPage {

    }
  }

  Component {
    id: detailPageComponent
    DetailPage {

    }
  }

  Component {
    id: speakerDetailPageComponent
    SpeakerDetailPage {

    }
  }

  Component {
    id: trackDetailPageComponent
    TrackDetailPage {

    }
  }
}
