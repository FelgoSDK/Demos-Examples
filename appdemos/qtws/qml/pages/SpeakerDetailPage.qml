import Felgo
import QtQuick
import "../common"
import "../details"

FlickablePage {
  id: speakerDetailPage

  property var speakerID
  readonly property bool isValid: (typeof(speakerID) !== "undefined") && dataModel.speakers && (typeof(dataModel.speakers[speakerID]) !== "undefined")
  property var speaker: isValid ? dataModel.speakers[speakerID] : {}

  backgroundColor: Theme.colors.secondaryBackgroundColor
  title: isValid ? speaker.full_name : ""

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


  flickable.contentWidth: parent && parent.width || 0
  flickable.contentHeight: contentCol.height

  Column {
    id: contentCol
    width: parent.width

    Item {
      width: parent.width
      height: dp(Theme.navigationBar.defaultBarItemPadding)
    }

    Row {
      id: row1
      spacing: dp(Theme.navigationBar.defaultBarItemPadding)
      width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
      anchors.horizontalCenter: parent.horizontalCenter

      SpeakerImage {
        id: avatar
        source: isValid ? speaker.avatar : ""
        width: dp(64)
        height: width
        activatePictureViewer: true
      }
      AppText {
        width: parent.width - avatar.width - row1.spacing
        text: isValid ? speaker.full_name : ""
        font.bold: true
        font.weight: Font.Bold
        font.family: Theme.boldFont.name
        anchors.verticalCenter: parent.verticalCenter
      }
    }

    Item {
      width: parent.width
      height: dp(Theme.navigationBar.defaultBarItemPadding)
    }

    AppText {
      readonly property bool hasTitle: speaker.title.length > 0

      width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
      anchors.horizontalCenter: parent.horizontalCenter
      text: hasTitle ? speaker.title : ""
      wrapMode: AppText.WordWrap
      color: Theme.secondaryTextColor
      leftPadding: dp(20)
      visible: hasTitle

      AppIcon {
        iconType: IconType.building
        color: Theme.secondaryTextColor
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.5
        size: dp(12)
      }
    }

    SimpleSection {
      title: "Talks"
    }

    Repeater {
      id: talksRepeater
      model: isValid ? speaker.talks : []
      delegate: TalkRow {
        schedule: dataModel.talks[modelData]
        showFavIcon: true
        showImg: false
        firstInSection: index === 0
        lastInSection: index >= talksRepeater.count -1
        onSelected: {
          speakerDetailPage.navigationStack.push(detailPageComponent, { item: schedule })
        }
      }
    }
  }

  function toggleFavorite(item) {
    logic.toggleFavorite(item)
  }
}
