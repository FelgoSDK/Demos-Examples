import Felgo 4.0
import QtQuick 2.0


Item {
  id: root

  signal clicked()

  width: parent.width
  height: dp(50)

  Rectangle {
    anchors.centerIn: parent
    width: parent.width * 0.9
    height: dp(45)
    radius: dp(4)

    Row {
      anchors.centerIn: parent
      spacing: dp(15)

      AppIcon {
        iconType: IconType.search
        color: "#3e3e3e"
      }

      AppText {
        text: qsTr("Artisits, songs, or podcasts")
        color: "#3e3e3e"
        font.bold: true
      }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: root.clicked()
    }
  }
}
