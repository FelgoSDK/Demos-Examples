import Felgo 3.0
import QtQuick 2.0
import "."

Rectangle {
  id: speakerRow
  height: row.height + dp(10) * 2
  width: !parent ? 0 :(small ? parent.width - dp(25) : parent.width) // dp(25) is section selection width
  color: Theme.listItem.backgroundColor
  property var speaker
  property bool small
  signal clicked

  property StyleSimpleRow style: StyleSimpleRow { }

  RippleMouseArea {
    anchors.fill: parent
    circularBackground: false
    onClicked: {
      speakerRow.clicked()
    }
  }

  Row {
    id: row
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.centerIn: parent
    spacing: dp(Theme.navigationBar.defaultBarItemPadding)

    SpeakerImage {
      id: avatar
      width: dp(speakerRow.style.fontSizeText) * 2.5
      height: width
      source: speaker === undefined ? "" : speaker.avatar
    }

    Column {
      width: parent.width - avatar.width - row.spacing
      anchors.verticalCenter: parent.verticalCenter
      spacing: dp(2)

      AppText {
        text: speaker === undefined ? "" : speaker.first_name ? speaker.first_name + " " + "<strong>"+speaker.last_name+"</strong>" : "<strong>"+speaker.last_name+"</strong>"
        width: parent.width
      }

      AppText {
        width: small? parent.width - dp(Theme.navigationBar.defaultBarItemPadding) : parent.width
        elide: AppText.ElideRight
        maximumLineCount: 1
        text: speaker ? speaker.title : ""
        color: Theme.secondaryTextColor
        font.pixelSize: sp(12)
//        leftPadding: dp(15)
        visible: speaker && speaker.title
        opacity: 0.65

//        Icon {
//          icon: IconType.building
//          color: Theme.secondaryTextColor
//          anchors.verticalCenter: parent.verticalCenter
//          opacity: 0.5
//          size: dp(10)
//        }
      }

      Repeater {
        id: talksRepeater
        model: speaker && speaker.talks || []

        AppText {
          width: small? parent.width - dp(Theme.navigationBar.defaultBarItemPadding) : parent.width
          elide: AppText.ElideRight
          maximumLineCount: 1
          text: dataModel.talks && dataModel.talks[modelData] ? dataModel.talks[modelData].title : ""
          color: Theme.secondaryTextColor
          font.pixelSize: sp(12)
        }
      }
    }
  }

  Rectangle {
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: Theme.isIos ? parent.width - avatar.width - row.spacing - dp(Theme.navigationBar.defaultBarItemPadding) : parent.width
    color: Theme.listItem.dividerColor
    height: px(1)
  }

  Icon {
    icon: IconType.angleright
    anchors.right: parent.right
    anchors.rightMargin: Theme.navigationBar.defaultBarItemPadding
    anchors.verticalCenter: parent.verticalCenter
    color: Theme.dividerColor
    visible: Theme.isIos
    size: dp(24)
  }
}
