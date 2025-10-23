import Felgo
import QtQuick
import QtQuick.Layouts
import "../common"
import "../details"

Column {
  id: container
  width: parent.width

  signal clicked
  signal favoriteClicked
  signal roomClicked(var room)
  signal trackClicked(var track)

  property var talk
  property bool isFavorite: talk && talk.id ? dataModel.isFavorite(talk.id) : false
  property bool small: false
  property bool isListItem: false
  property bool moreRooms: typeof(talk.room) !== "string"
  property bool isGeneralEvent: talk.room === "Level B"

  readonly property bool navigationEnabled: appDetails.roomNavigationAvailable && talk.room !== "Level B"

  // private members
  Item {
    id: _
    readonly property color dividerColor: Theme.dividerColor
    readonly property color iconColor:  Theme.secondaryTextColor
    readonly property var rowSpacing: dp(10)
    readonly property var colSpacing: dp(20)
    readonly property real speakerImgSize: dp(Theme.navigationBar.defaultIconSize) * 4
    readonly property real speakerTxtWidth: sp(150)
    readonly property real favoriteTxtWidth: sp(150)
    property int loadingCount: 0
  }

  Column {
    width: parent.width

    AppListItem {
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          iconType: IconType.clocko
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      firstInSection: true
      text: talk.weekday + " " + talk.start
      showDisclosure: false
      enabled: false
      muted: true
      onSelected: {

      }
    }

    AppListItem {
      visible: !isGeneralEvent
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          iconType: isFavorite ? IconType.star : IconType.staro
          size: dp(17)
          anchors.centerIn: parent
          color: Theme.tintColor
        }
      }
      rightPadding: dp(5)
      rightItem: Item {
        width: dp(26)
        height: parent.height
        visible: isFavorite
        AppIcon {
          iconType: IconType.check
          size: dp(17)
          anchors.centerIn: parent
          color: Theme.tintColor
        }
      }

      text: "Favorite"
      showDisclosure: false
      textColor: Theme.tintColor
      onSelected: {
        container.favoriteClicked()
      }
    }

    AppListItem {
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          iconType: IconType.mapmarker
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      text: if(navigationEnabled) {
              if(moreRooms) {
                "Show " + talk.room[0]
              }
              else {
                "Show " + talk.room
              }
            }
            else {
              talk.room
            }
      enabled: navigationEnabled
      muted: !enabled
      onSelected: {
        moreRooms ? container.roomClicked(talk.room[0]) : container.roomClicked(talk.room)
      }
    }

    AppListItem {
      visible: moreRooms
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          iconType: IconType.mapmarker
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      text: moreRooms ? navigationEnabled ? "Show " + talk.room[1] : talk.room[1] : ""
      enabled: navigationEnabled
      onSelected: {
        container.roomClicked(talk.room[1])
      }
    }

    AppListItem {
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height

        Rectangle {
          width: dp(18)
          height: dp(18)
          color: talk.color
          anchors.centerIn: parent
          radius: dp(5)
        }
      }

      text: talk.tracks
      lastInSection: isGeneralEvent
      onSelected: trackItem => {
        for(trackItem in dataModel.tracks) {
          console.log(dataModel.tracks[trackItem].title)
          if(talk.tracks === dataModel.tracks[trackItem].title) {
            container.trackClicked(dataModel.tracks[trackItem])
            console.log(dataModel.tracks[trackItem].title)
            return
          }
        }
      }
    }

    AppListItem {
      visible: !isGeneralEvent
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          iconType: IconType.share
          size: dp(17)
          anchors.centerIn: parent
        }
      }

      text: "Share this Session"
      lastInSection: true
      onSelected: {
        nativeUtils.share("I am attending \"" + talk.title + "\" at " + eventDetails.name + "!\nhttps://www.qt.io/qt-world-summit-2023", "")
      }
    }
  }
}
