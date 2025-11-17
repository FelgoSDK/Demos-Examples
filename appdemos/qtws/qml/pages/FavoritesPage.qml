import Felgo
import QtQuick
import "../common"
import QtQuick.Controls as QtQuick2
import "../details"

AppPage {
  id: page
  title: "Favorites"
  rightBarItem: ActivityIndicatorBarItem { opacity: dataModel.loading || scheduleItem.loading ? 1 : 0 }
  backgroundColor: Theme.colors.secondaryBackgroundColor

  property var favoritesModel: dataModel.favorites ? Object.values(dataModel.favorites) : []
  readonly property bool dataAvailable: favoritesModel.length > 0

  Connections {
    target: navigation.tabs
    function onTabClicked(tab, index) {
      if(index !== navigation.latestIndex) {
        return
      }

      // scroll to top
      var pos = scheduleItem.listView.contentY
      var destPos = scheduleItem.listView.originY
      anim.from = pos
      anim.to  = destPos
      anim.running = true
    }
  }

  NumberAnimation { id: anim; target: scheduleItem.listView; to: 0; property: "contentY"; duration: 240 }

  AppText {
    text: "No talks added to favorites yet."
    visible: !dataAvailable
    anchors.centerIn: parent
  }

  TimetableDaySchedule {
    id: scheduleItem
    anchors.fill: parent
    talkIds: favoritesModel
    searchAllowed: false
    onItemClicked: item => {
      page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, { item: item })
    }
    visible: dataAvailable
    autoJumpToNow: false
  }
}
