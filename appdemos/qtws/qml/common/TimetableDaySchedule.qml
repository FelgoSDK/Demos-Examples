
import Felgo
import QtQuick
import "../common"
import "../details"

Item {
  id: dayScheduleItem

  property var talkIds: []
  property var sectionRole: "date"

  signal itemClicked(var item);

  readonly property bool loading: _.loadingCount > 0

  property alias emptyText: listView.emptyText

  property bool searchAllowed: true

  property alias listView: listView

  property bool showFavIcon: true

  property bool autoJumpToNow: true

  signal searchAccepted(string text)

  // scroll to talk of current time initially
  Timer {
    id: moveToNowInitTimer
    repeat: false
    running: autoJumpToNow
    interval: 350
    onTriggered: {
      listView.jumpToNow(true)
    }
  }

  // private members
  Item {
    id: _
    property int loadingCount: 0
    property var scheduleData: Object.values(dataModel.talks).filter(talk => talkIds.includes(talk.id))
  }

  // jump to now button (top)
  JumpToNowButton {
    id: jumpToNowTop

    // determine if a button jumps to now or top
    property bool now: true

    // whether the button should be visible, will be set while scrolling through view
    property bool show: false

    z: 1
    y: show ? dp(5) : -height
    opacity: show ? 1 : 0
    text: now ? "now" : "to top"

    // onClicked - jump to list view position
    onClicked: {
      if(now) {
        listView.jumpToNow()
      } else {
        listView.positionViewAtBeginning()
      }

      show = false
    }
  }

  // jump to now button (bottom)
  JumpToNowButton {
    id: jumpToNowBottom

    // determine if a button jumps to now or botom
    property bool now: true

    // whether the button should be visible, will be set while scrolling through view
    property bool show: false

    z: 1
    opacity: show ? 1 : 0
    text: now ? "now" : "to bottom"

    anchors.bottom: parent.bottom
    anchors.bottomMargin: show ? dp(5) : -height
    useYAnimation: false

    // onClicked - jump to list view position
    onClicked: {
      listView.jumpToNow()
      show = false
    }
  }

  // show/hide jump to now buttons
  Connections {
    id: updater
    target: listView
    function onFirstVisibleItemIndexChanged() {
      Qt.callLater(updateJumpButtons)
    }

    function  onLastVisibleItemIndexChanged() {
      Qt.callLater(updateJumpButtons)
    }

    // update visibility settings of jump to now button
    function updateJumpButtons() {
      if(moveToNowInitTimer.running || listScrollAnim.running) {
        return
      }

      if(listView.count <= 0) {
        jumpToNowTop.show = false
        jumpToNowBottom.show = false
        return
      }

      var now = new Date()
      var nowItemIdx = listView.itemIndexForTime(now.getTime())

      // check if nowItem (nearest) is not today -> always show scroll to top then
      var nowItemDate = listView.model.get(nowItemIdx).datetime
      if(!nowItemDate || nowItemDate.getFullYear() !== now.getFullYear() || nowItemDate.getMonth() !== now.getMonth() || nowItemDate.getDate() !== now.getDate()) {
        nowItemIdx = 0
      }

      // use scroll to top if first
      jumpToNowTop.now = (nowItemIdx !== 0)
      jumpToNowBottom.now = (nowItemIdx !== (listView.count - 1))

      // show/hide correct buttons
      jumpToNowBottom.show = (nowItemIdx > listView.lastVisibleItemIndex && listView.firstVisibleItemIndex >= 0 && listView.lastVisibleItemIndex >= 0)
      jumpToNowTop.show = !jumpToNowBottom.show && (nowItemIdx < listView.firstVisibleItemIndex)
    }
  }

  // app list view with daily schedule
  AppListView {
    id: listView
    width: parent.width
    height: parent.height - y
    topMargin: Theme.isIos ? dp(Theme.contentPadding) : 0
    bottomMargin: dp(Theme.contentPadding)
    model: SortFilterProxyModel {
      id: listModel
      sourceModel: JsonListModel {
        source: _.scheduleData
        keyField: "id"
      }

      sorters: [
        RoleSorter {
          roleName: "day"
        },
        ExpressionSorter {
          expression: {
            return modelLeft.start.split(":")[0].length > modelRight.start.split(":")[0].length
          }
          sortOrder: Qt.DescendingOrder
        },
        RoleSorter {
          roleName: "start"
        }
      ]
    }

    // search header for listview
    header: SearchBar {
      visible: searchAllowed
      height: searchAllowed ? implicitHeight : 0
      onAccepted: text => searchAccepted(text)
      iosAlternateStyle: true
      barBackgroundColor: Theme.isAndroid ? (appDetails.darkMode ? eventDetails.lightPineColor : Theme.backgroundColor) : Theme.secondaryBackgroundColor
      inputBackgroundColor: appDetails.darkMode ? eventDetails.lightPineColor : Theme.backgroundColor
    }

    // row item config
    delegate: TalkRow {
      schedule: listModel.get(index)
      showFavIcon: dayScheduleItem.showFavIcon

      onSelected: index => {
        listView.currentIndex = index
        dayScheduleItem.itemClicked(schedule)
      }
    }

    // section config
    section.property: sectionRole
    section.delegate: SimpleSection {
      style.compactStyle: true
      textItem.horizontalAlignment: Text.AlignHCenter
    }

    emptyText.text: qsTr("No events.")

    // provide index of first and last visible item
    property int firstVisibleItemIndex: -1
    property int lastVisibleItemIndex: -1

    // all 3 required for index to initialize properly on startup
    onHeightChanged: Qt.callLater(updateVisibleItems)
    onContentHeightChanged: Qt.callLater(updateVisibleItems)
    onContentYChanged: Qt.callLater(updateVisibleItems)

    function updateVisibleItems() {
      firstVisibleItemIndex = nearestIndexAtY(contentY, true)
      lastVisibleItemIndex = nearestIndexAtY(contentY + height, false)
    }

    // nearestIndexAtY - returns nearest item index for x,y position
    function nearestIndexAtY(yPos, forward) {
      if (height <= 0) {
        return 0
      }

      var xPos = listView.width * 0.5 // x axis is not at interest
      var relaxationStep = dp(10)

      var index = -1
      var relaxation = 0

      while(index === -1 && Math.abs(relaxation) < height * 0.5) {
        index = listView.indexAt(xPos, yPos + relaxation)

        // if nothing found (e.g. section is at chosen point) -> retry with relaxation factor
        relaxation += forward ? relaxationStep : -relaxationStep;
      }

      return index
    }

    // itemIndexForTime - get item index for time in ms
    function itemIndexForTime(time) {
      for(var i = 0; i < count; ++i) {
        var talkItem = model.get(i)
        var talkTime = talkItem.datetime.getTime()
        if(talkTime >= time) {
          break
        }
      }
      return i
    }

    // scrollToIndex - scrolls listview to item with given index
    function scrollToIndex(idx) {
      let currContentY = listView.contentY
      listView.positionViewAtIndex(idx, ListView.Beginning)
      let targetContentY = listView.contentY
      listView.contentY = currContentY

      listScrollAnim.from = currContentY
      listScrollAnim.to = targetContentY
      listScrollAnim.start()
    }

    PropertyAnimation {
      id: listScrollAnim
      target: listView
      property: "contentY"
      duration: 250
      onStopped: updater.updateJumpButtons()
    }

    // jumpToNow - jumps to list entry matching current time
    function jumpToNow(initialCall = false) {
      var now = Date.now()
      var nowItemIndex = itemIndexForTime(now)
      if(nowItemIndex < 0)
        return

      if(nowItemIndex == 0 && initialCall)
        return

      listView.scrollToIndex(nowItemIndex)
    }
  }
}
