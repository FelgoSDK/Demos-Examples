import Felgo
import QtQuick
import "."

AppListItem {
  id: listItem
  insetStyle: Theme.isIos

  property var speaker

  text: listItem.speaker.full_name

  leftItem: SpeakerImage {
    id: avatar
    width: dp(48)
    height: width
    source: listItem.speaker !== undefined ? listItem.speaker.avatar : ""
    anchors.verticalCenter: parent.verticalCenter
  }

  detailTextItem: Column {
    AppText {
      width: listItem.textItemAvailableWidth
      maximumLineCount: 1
      elide: Text.ElideRight
      text: listItem.speaker && listItem.speaker.title ? listItem.speaker.title : ""
      visible: text.length > 0
      color: Theme.secondaryTextColor
      font.pixelSize: sp(12)
    }

    Repeater {
      model: speaker && speaker.talks || []

      AppText {
        width: listItem.textItemAvailableWidth
        maximumLineCount: 1
        elide: Text.ElideRight
        text: dataModel.talks && dataModel.talks[modelData] ? dataModel.talks[modelData].title : ""
        visible: text.length > 0
        color: Theme.colors.tintColor
        font.pixelSize: sp(12)
      }
    }
  }
}
