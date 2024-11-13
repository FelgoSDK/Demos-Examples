import Felgo
import QtQuick
import "../common"
import "../details"

ListPage {
  id: tracksPage

  property var tracksModel: dataModel.tracks !== undefined ? dataModel.tracks : { }

  Connections {
    target: navigation.tabs
    function onTabClicked(tab, index) {
      if(index !== navigation.latestIndex) {
        return
      }

      // scroll to top
      var pos = listView.contentY
      var destPos = listView.originY
      anim.from = pos
      anim.to  = destPos
      anim.running = true
    }
  }

  NumberAnimation { id: anim; target: listView; to: 0; property: "contentY"; duration: 240 }

  title: "Tracks"
  listView.topMargin: dp(Theme.contentPadding)
  listView.bottomMargin: dp(Theme.contentPadding)
  backgroundColor: Theme.colors.secondaryBackgroundColor

  model: JsonListModel {
    id: listModel
    source: dataModel.tracks
    keyField: "title"
    fields: ["title", "talks", "color"]
  }

  delegate: AppListItem {
    id: trackItem
    insetStyle: Theme.isIos
    property var track: listModel.get(index)
    text: track.title
    detailText: track.talks.length + " Sessions"
    leftPadding: dp(24)

    Rectangle {
      x: dp(10)
      width: dp(6)
      radius: dp(3)
      height: trackItem.height - dp(20)
      color: track.color
      anchors.verticalCenter: parent.verticalCenter
    }

    onSelected: {
      tracksPage.navigationStack.push(trackDetailPageComponent, { track: track })
    }
  }
}
