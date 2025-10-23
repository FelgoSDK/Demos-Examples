import Felgo
import QtQuick
import "../common"
import "./components"
import "../details"

FlickablePage {
  id: mainPage
  title: "Main"
  navigationBarHidden: !Theme.isAndroid

  Connections {
    target: navigation.tabs
    function onTabClicked(tab, index) {
      if(index !== navigation.latestIndex) {
        return
      }

      // scroll to top
      var pos = flickable.contentY
      var destPos = flickable.originY
      anim.from = pos
      anim.to  = destPos
      anim.running = true
    }
  }

  NumberAnimation { id: anim; target: flickable; to: 0; property: "contentY"; duration: 240 }

  // set up navigation bar
  titleItem: Item {
    visible: !mainPage.navigationBarHidden
    width: dp(50)
    implicitWidth: img.width
    height: dp(Theme.navigationBar.height)

    Image {
      id: img
      source: "../../assets/Qt_logo.png"
      width: dp(50)
      height: parent.height * 0.6

      fillMode: Image.PreserveAspectFit
      y: Theme.isAndroid ? dp(Theme.navigationBar.titleBottomMargin) + dp(10) : dp(10)
    }
  }

  flickable.contentWidth: width
  flickable.contentHeight: Math.max(flickable.height, content.height)

  // page content
  Column {
    id: content
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter

    property real descriptionTextMaxWidth: Math.min(parent.width - dp(Theme.contentPadding) * 3, dp(600))

    Rectangle {
      width: parent.width
      height: eventInfoItem.height
      color: Theme.secondaryBackgroundColor

      Column {
        id: infoColumn
        anchors.fill: parent
        spacing: appDetails.darkMode ? 0 : dp(Theme.contentPadding)
        bottomPadding: !appDetails.darkMode ? 0 : dp(Theme.contentPadding)

        EventInfoItem {
          id: eventInfoItem
          width: parent.width
          descriptionTextMaxWidth: content.descriptionTextMaxWidth
        }
      }
    }

    AtTheVenueInfoItem {
      width: parent.width
    }

    FelgoInfoItem {
      id: felgoInfo
      width: parent.width
      descriptionTextMaxWidth: content.descriptionTextMaxWidth
    }

    // spacer
    Rectangle {
      width: parent.width
      height: dp(20)
      color: felgoInfo.backgroundColor
    }
  }
}
