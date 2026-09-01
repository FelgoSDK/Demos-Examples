import Felgo
import QtQuick
import "../common"
import QtQuick.Controls as QtQuick2
import "../details"

AppPage {
  id: page
  title: searchModel.length + " results"
  rightBarItem: ActivityIndicatorBarItem { opacity: dataModel.loading || scheduleItem.loading ? 1 : 0 }

  property var searchModel: []
  readonly property bool dataAvailable: searchModel !== undefined && searchModel.length > 0

  AppText {
    text: "No talks found for search."
    visible: !dataAvailable
    anchors.centerIn: parent
  }

  TimetableDaySchedule {
    id: scheduleItem
    anchors.fill: parent
    talkIds: page.searchModel ? page.searchModel : []
    searchAllowed: false
    onItemClicked: item => {
      page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, { item: item })
    }
    visible: dataAvailable
  }
}
