import Felgo
import QtQuick
import "../common"
import QtQuick.Controls as QtQuick2
import "../details"

AppPage {
  id: page
  title: "Agenda"
  rightBarItem: ActivityIndicatorBarItem { opacity: dataModel.loading || currentContentLoading ? 1 : 0 }
  backgroundColor: Theme.colors.secondaryBackgroundColor

  readonly property var daysModel: dataModel.schedule
  readonly property bool dataAvailable: daysModel.length > 0

  readonly property var currentContentItem: swipeView.itemAt(swipeView.currentIndex)
  readonly property bool currentContentLoading: !currentContentItem ? false : currentContentItem.loading

  Connections {
    target: navigation.tabs
    function onTabClicked(tab, index) {
      if(index !== navigation.latestIndex) {
        return
      }

      // scroll to top
      var pos = swipeViewRepeater.itemAt(swipeView.currentIndex).listView.contentY
      var destPos = swipeViewRepeater.itemAt(swipeView.currentIndex).listView.originY
      anim.from = pos
      anim.to  = destPos
      anim.running = true
    }
  }

  NumberAnimation { id: anim; target: swipeViewRepeater.itemAt(swipeView.currentIndex).listView; to: 0; property: "contentY"; duration: 240 }

  AppText {
    text: "No data available."
    visible: !dataAvailable
    anchors.centerIn: parent
  }

  // tab bar
  AppTabBar {
    id: appTabBar
    showIcon: false
    visible: dataAvailable
    contentContainer: swipeView

    // auto select tab of current day after tab-bar was built
    property int autoSelectTab: -1
    onCountChanged: {
      if(autoSelectTab > 0 && dataAvailable && appTabBar.count === daysModel.length)
        appTabBar.currentIndex = autoSelectTab
    }

    Repeater {
      // dummyData to avoid tabcontrol issue when no children
      property var dummyData: [{ "day" : 0, "weekday" : "", "talks": undefined }]
      model: dataAvailable ? daysModel : dummyData
      delegate: AppTabButton {
          text: Theme.isAndroid ? modelData.weekday.substring(0, 3) : modelData.weekday
      } // AppTabButton

    } // Repeater
  } // AppTabBar

  // tab contents
  QtQuick2.SwipeView {
    id: swipeView
    y: appTabBar.height
    height: parent.height - y
    width: parent.width
    clip: true

    visible: dataAvailable
    currentIndex: appTabBar.currentIndex

    Repeater {
      id: swipeViewRepeater
      property var dummyData: [{ "day" : 0, "weekday" : "", "talks": undefined }]
      model: dataAvailable ? daysModel : dummyData
      delegate: TimetableDaySchedule {
        id: timetableDaySchedule
        width: page.navigationStack.splitViewActive ? page.navigationStack.leftColumnWidth : page.width
        height: parent.height
        talkIds: modelData.talks
        sectionRole: "start"

        onSearchAccepted: text => {
          if(text !== "") {
            var result = logic.search(text, dataModel.talks)
            page.navigationStack.popAllExceptFirstAndPush(Qt.resolvedUrl("SearchPage.qml"), { searchModel: result })
          }
          else
            page.navigationStack.popAllExceptFirst()
        }

        onItemClicked: item => {
          page.navigationStack.popAllExceptFirstAndPush(detailPageComponent, { item: item })
        }
      }
    }
  }
}
