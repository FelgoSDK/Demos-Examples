import Felgo 3.0
import QtQuick 2.0


Item {
  id: root

  property real margins: 0
  signal selected()

  AppPaper {
    id: appPaper

    property real elevatedPadding: elevated ? dp(2) : 0

    anchors {
      left: parent.left
      leftMargin: index % 2 == 0 ? root.margins + elevatedPadding : root.margins / 2 + elevatedPadding
      top: parent.top
      topMargin: elevatedPadding
    }

    width: parent.width - margins * 1.5 - elevatedPadding * 2
    height: parent.height - margins - elevatedPadding * 2
    clip: true

    background.color: tileColor
    elevated: mouseArea.pressed
    radius: dp(5)

    AppText {
      width: parent.width / 2

      anchors {
        top: parent.top
        topMargin: dp(15)
        left: parent.left
        leftMargin: dp(10)
      }

      font.bold: true
      text: term
      wrapMode: Text.WordWrap
    }


    AppPaper {
      width: dp(50)
      height: dp(50)

      anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: - width / 3
      }

      rotation: 25
    }

    MouseArea {
      id: mouseArea
      anchors.fill: parent

      onClicked: {
        root.selected()
      }
    }
  }
}
