import Felgo
import QtQuick
import QtQuick.Layouts
import "../common"
import "../details"

AppListItem {
  id: listItem
  property var schedule
  property bool showFavIcon: false
  property bool isFavorite: schedule && schedule.id ? dataModel.isFavorite(schedule.id) : false
  property bool showImg: true
  property bool isGeneralEvent: schedule.room === "Level B"

  property string room: if(listItem.schedule.room && listItem.schedule.room !== eventDetails.name) {
                          if(typeof(listItem.schedule.room) === "string") {
                            listItem.schedule.room
                          }
                          else {
                            listItem.schedule.room[0] + ", " + listItem.schedule.room[1]
                          }
                        }
                        else {
                          ""
                        }

  insetStyle: Theme.isIos
  text: listItem.schedule.title || ""
  detailText: listItem.schedule.start + (listItem.schedule.end ? (" - " + listItem.schedule.end) : "")
  leftPadding: dp(24)
  showDisclosure: false
  rightPadding: rightItem ? dp(0) : dp(Theme.contentPadding)

  Rectangle {
    x: dp(10)
    width: dp(6)
    radius: dp(3)
    height: listItem.height - dp(20)
    color: listItem.schedule.color || Theme.tintColor
    anchors.verticalCenter: parent.verticalCenter
  }

  leftItem: listItem.showImg ? speakerImgComp.createObject(listItem) : null

  Component {
    id: speakerImgComp
    SpeakersImages {
      id: speakerImg
      height: dp(48)
      width: dp(48)
      anchors.verticalCenter: parent ? parent.verticalCenter : undefined

      property var speakersIds: listItem.schedule.speakers && listItem.schedule.speakers.length > 0 ? listItem.schedule.speakers : undefined
      sources: {
        if(isGeneralEvent) {
          listItem.leftItem = qtLogoComp.createObject(listItem)
        } else {
          var avatars = []
          if(speakerImg.speakersIds !== undefined) {
            for (var speakerId of speakerImg.speakersIds) {
              var speaker = speakerId !== undefined ? dataModel.speakers[speakerId] : {}
              avatars.push(speaker.avatar)
            }
            return avatars
          }
          else {
            listItem.leftItem = qtLogoComp.createObject(listItem)
          }
        }
      }
    } // SpeakerImage
  }

  Component {
    id: qtLogoComp
    AppImage {
      width: dp(48)
      fillMode: Image.PreserveAspectFit
      anchors.verticalCenter: parent ? parent.verticalCenter : undefined
      source: "../../assets/qt-button-black.png"
      opacity: 0.25
    }
  }

  rightItem: listItem.showFavIcon && !isGeneralEvent ? favIconComp.createObject(listItem) : null

  Component {
    id: favIconComp

    Item {
      height: listItem.height
      width: dp(35)

      Rectangle {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.isIos ? dp(4) : dp(6)
        anchors.right: parent.right
        anchors.rightMargin: dp(4)
        width: dp(30)
        height: width
        radius: dp(10)
        color: appDetails.darkMode ? eventDetails.pineColor : "#fff"
        border.width: appDetails.darkMode ? 0 : px(1)
        border.color: Theme.tintColor

        AppIcon {
          id: favoriteIconSmall
          iconType: listItem.isFavorite ? IconType.star : IconType.staro
          color: Theme.tintColor
          anchors.centerIn: parent
          size: dp(20)
        }

        // add/remove from favorites
        RippleMouseArea {
          width: parent.width * 2
          height: parent.height * 2
          fixedPosition: true
          touchPoint: Qt.point(width * 0.5, height * 0.5)
          anchors.centerIn: parent
          onClicked: {
            logic.toggleFavorite(listItem.schedule)
          }
        }
      }
    }
  }

  Row {
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.rightMargin: listItem.rightItem ? dp(50) : listItem.rightPadding
    anchors.bottomMargin: listItem.bottomPadding
    spacing: dp(6)

    AppIcon {
      iconType: IconType.mapmarker
      color: listItem.detailTextColor
      size: dp(14)
      anchors.verticalCenter: parent.verticalCenter
    }

    AppText {
      text: listItem.room
      color: listItem.detailTextColor
      font.pixelSize: listItem.detailTextFontSize
    }
  }
}
