import Felgo
import QtQuick
import QtQuick.Layouts
import "../common"
import "../details"
import "../model"

FlickablePage {
  id: detailPage

  property var item
  property bool isFavorite: item && item.id ? dataModel.isFavorite(item.id) : false
  readonly property bool loading: _.loadingCount > 0
  property bool isGeneralEvent: item.room === "Level B"

  title: item.title

  backgroundColor: Theme.colors.secondaryBackgroundColor

  flickable.bottomMargin: dp(Theme.contentPadding)

  rightBarItem: NavigationBarRow {
    showMoreButton: false
    ActivityIndicatorBarItem { visible: dataModel.loading || detailPage.loading ? true : false }
    IconButtonBarItem {
      iconType: detailPage.isFavorite ? IconType.star : IconType.staro
      onClicked: detailPage.toggleFavorite()
      showItem: showItemAlways
      visible: !isGeneralEvent
    }
  }

  // update UI when favorites change
  Connections {
    target: dataModel
    function onFavoritesChanged() {
      detailPage.isFavorite = item && item.id ? dataModel.isFavorite(item.id) : false
    }
  }

  // private members
  Item {
    id: _
    readonly property color dividerColor: Theme.dividerColor
    readonly property color iconColor:  Theme.secondaryTextColor
    readonly property var rowSpacing: dp(10)
    readonly property var colSpacing: dp(20)
    readonly property real speakerImgSize: dp(64)//dp(Theme.navigationBar.defaultIconSize) * 4
    readonly property real speakerTxtWidth: sp(150)
    readonly property real favoriteTxtWidth: sp(150)
    property int loadingCount: 0
  }

  flickable.contentHeight: contentCol.height + 2 * contentCol.y

  // content column
  Column {
    id: contentCol
    y: 2 * spacing
    width: parent.width

    Item {
      id: titleArea
      width: parent.width
      height: _.colSpacing * 2 + titleTextItem.height

      Item {
        width: parent.width
        height: _.colSpacing
      }

      // title
      AppText {
        id: titleTextItem
        y: _.colSpacing
        text: item.title
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: Text.WordWrap
        font.bold: true
        font.weight: Font.Bold
        font.family: Theme.boldFont.name
      }
    }

    Column {
      topPadding: _.colSpacing
      bottomPadding: _.colSpacing * 1.1
      width: parent.width

      Row {
        id: mainSpeakerRow
        readonly property var validSpeakers: item && item.speakers && dataModel.speakers && (typeof(dataModel.speakers[item.speakers]) !== undefined)
        readonly property var mainSpeakerId: item.speakers[0]
        readonly property var mainSpeakerData: dataModel.speakers[mainSpeakerId]

        leftPadding: dp(Theme.contentPadding)
        visible: item.speakers && item.speakers.length > 0
        spacing: dp(Theme.navigationBar.defaultBarItemPadding)

        // speakers images
        SpeakersImages {
          id: speakersImgs
          width:  _.speakerImgSize
          height: width
          anchors.verticalCenter: parent.verticalCenter

          property var speakersIds: mainSpeakerRow.validSpeakers ? item.speakers : undefined
          sources: {
            var avatars = []
            for (var speakerId of speakersIds) {
              var speaker = speakerId !== undefined ? dataModel.speakers[speakerId] : {}
              avatars.push(speaker.avatar)
            }
            return avatars
          }

          onLoadingChanged: {
            if(loading)
              _.loadingCount++
            else
              _.loadingCount--
          }
        }

        Column {
          width: _.speakerTxtWidth
          anchors.verticalCenter: parent.verticalCenter

          // speaker name
          AppText {
            id: speakerTxt
            wrapMode: Text.WordWrap
            text: mainSpeakerRow.validSpeakers && mainSpeakerRow.mainSpeakerData?.full_name || ""
            RippleMouseArea {
              width: mainSpeakerRow.width
              height: mainSpeakerRow.height
              anchors.right: parent.right
              anchors.verticalCenter: parent.verticalCenter
              fixedPosition: true
              centerAnimation: true
              touchPoint: Qt.point(speakersImgs.width * 0.5, height * 0.5)
              onClicked: {
                detailPage.navigationStack.push(Qt.resolvedUrl("SpeakerDetailPage.qml"), { speakerID: mainSpeakerRow.mainSpeakerId })
              }
            }

          }

          // and others
          AppText {
            width: _.speakerTxtWidth
            wrapMode: Text.WordWrap
            text: qsTr("and others")
            visible: mainSpeakerRow.validSpeakers && item.speakers.length > 1

            fontSize: speakerTxt.fontSize * 0.7
            font.italic: true
            }
        }
      }

      Item {
        width: parent.width
        height: _.colSpacing
        visible: mainSpeakerRow.visible
      }

      TalkDetails {
        width: parent.width
        talk: item
        onFavoriteClicked: toggleFavorite()
        onRoomClicked: room => { detailPage.navigationStack.push(Qt.resolvedUrl("RoomPage.qml"), { room: room }) }
        onTrackClicked: track => {
          if(Theme.isAndroid)
            detailPage.navigationStack.push(Qt.resolvedUrl("TrackDetailPage.qml"), { track: track })
          else
            detailPage.navigationStack.push(Qt.resolvedUrl("TrackDetailPage.qml"), { track: track })
        }
      }
    }

    SimpleSection {
      visible: !isGeneralEvent
      title: "Description"
    }

    // spacing
    Item {
      visible: !isGeneralEvent
      width: parent.width
      height: _.rowSpacing
    }

    // description
    AppText {
      id: descriptionTxt
      text: item.description
      width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
      anchors.horizontalCenter: parent.horizontalCenter
      wrapMode: Text.WordWrap
      font.pixelSize: sp(15)
      visible: item.description.length > 0 && !isGeneralEvent
    }

    Column {
      width: parent.width
      visible: item.speakers && item.speakers.length > 0

      Item {
        width: parent.width
        height: dp(Theme.navigationBar.defaultBarItemPadding)
        visible: Theme.isAndroid
      }

      SimpleSection {
        title: "Speakers"
      }

      Repeater {
        id: speakerRepeater
        model: item && item.speakers ? item.speakers : []
        delegate: SpeakerRow {
          speaker: dataModel.speakers && dataModel.speakers[modelData]
          firstInSection: index === 0
          lastInSection: index >= speakerRepeater.count -1
          onSelected: {
            detailPage.navigationStack.push(Qt.resolvedUrl("SpeakerDetailPage.qml"), { speakerID: modelData })
          }
        }
      }
    }
  } // content column

  // add or remove item from favorites
  function toggleFavorite() {
    logic.toggleFavorite(item)
  }
} // page
