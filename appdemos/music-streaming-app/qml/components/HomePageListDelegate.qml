import Felgo 4.0
import QtQuick 2.0

Item {
  id: root

  signal selected()

  width: dp(150)
  height: dp(180)

  AppImage {
    id: coverImage
    width: parent.width
    height: width

    source: Qt.resolvedUrl(dataModel.getCover(model))
  }

  AppText {
    anchors { top: coverImage.bottom; topMargin: dp(5) }

    font.bold: true
    fontSize: 13
    text: model.name
  }

  MouseArea {
    anchors.fill: parent
    onClicked: root.selected()
  }
}
