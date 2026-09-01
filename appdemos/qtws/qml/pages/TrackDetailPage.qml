import Felgo
import QtQuick
import "../common"
import "../details"

AppPage {
  id: page
  title: track.title
  backgroundColor: Theme.colors.secondaryBackgroundColor

  property var track

  TimetableDaySchedule {
    width: parent.width
    height: parent.height
    talkIds: track.talks
    searchAllowed: false
    onItemClicked: function(item) {
      page.navigationStack.push(detailPageComponent, { item: item })
    }
  }
}
