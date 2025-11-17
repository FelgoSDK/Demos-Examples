import QtQuick
import Felgo

AppText {
  width: parent.width
  height: dp(48)
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

  text: "https://felgo.com"

  color: Theme.tintColor
  font.pixelSize: sp(16)

  MouseArea {
    id: mouse
    anchors.fill: parent
    onClicked: Qt.openUrlExternally("https://felgo.com")
    cursorShape: Qt.PointingHandCursor
  }
}
