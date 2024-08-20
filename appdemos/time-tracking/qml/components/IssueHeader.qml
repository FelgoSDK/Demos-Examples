import Felgo 4.0
import QtQuick 2.9

Column {
  property var issue

  width: parent.width - 2*dp(Theme.contentPadding)
  anchors.horizontalCenter: parent.horizontalCenter
  topPadding: dp(Theme.contentPadding)
  bottomPadding: 2*dp(Theme.contentPadding)
  spacing: dp(5)

  Row {
    spacing: dp(10)

    AppImage {
      width: dp(20)
      height: width
      source: Qt.resolvedUrl(issue.imageSrc)
    }
    AppText {
      text: issue.label
      font.bold: true
    }
    AppText {
      text: issue.title
    }
  }

  Rectangle {
    color: dataModel.getStatusColor(issue.status)
    radius: height/2
    width: badgeText.width + dp(10)
    height: badgeText.height + dp(5)

    AppText {
      id: badgeText
      color: Theme.listItem.badgeTextColor
      font.pixelSize: sp(Theme.listItem.badgeFontSize)
      text: dataModel.getStatus(issue.status)
      anchors.centerIn: parent
    }
  }
}
