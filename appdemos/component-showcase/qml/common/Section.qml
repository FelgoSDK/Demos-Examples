import QtQuick
import Felgo


Rectangle {
  id: root

  default property alias content: contentItem.children
  property alias title: titleSection.title
  property real topPadding: dp(10)
  property real bottomPadding: 0
  property real margin: 0
  property real spacing: 0

  width: parent.width
  height: titleSection.height + contentItem.height + topPadding + bottomPadding

  color: Theme.backgroundColor

  SimpleSection {
    id: titleSection
  }

  Column {
    id: contentItem
    anchors {
      horizontalCenter: parent.horizontalCenter
      top: titleSection.bottom
      topMargin: root.topPadding
    }

    width: parent.width - 2 * root.margin

    spacing: root.spacing
  }

  Item {
    anchors.top: contentItem.bottom
    width: parent.width
    height: root.bottomPadding
  }
}
