import Felgo 4.0
import QtQuick 2.0
import "../common"

AppPage {
  id: page
  title: track.title

  onPushed: amplitude.logEvent("View Track",{"track" : title})

  property var track

  TimetableDaySchedule {
    width: parent.width
    height: parent.height
    scheduleData: track.talks
    searchAllowed: false
    onItemClicked: {
      //page.navigationStack.push(Qt.resolvedUrl("DetailPage.qml"), { item: item })
      page.navigationStack.push(detailPageComponent, { item: item })
    }
  }

}
