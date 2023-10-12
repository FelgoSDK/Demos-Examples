import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.12

Rectangle {

  signal clickedNew()

  width: parent.width
  height: contentRow.height + 2*dp(Theme.contentPadding)
  color: Theme.colors.tintColor
  z: 10

  RowLayout {
    id: contentRow
    width: parent.width
    anchors.centerIn: parent
    spacing: dp(Theme.contentPadding)

    RoundedImage {
      source: Qt.resolvedUrl("../../assets/chris.jpg")
      Layout.preferredWidth: dp(50)
      Layout.preferredHeight: width
      Layout.leftMargin: dp(Theme.contentPadding)
      radius: width/2
      fillMode: Image.PreserveAspectFit
    }

    Column {
      spacing: dp(5)

      AppText {
        text: "Today"
        font.bold: true
        color: "white"
      }

      AppText {
        text: dataModel.totalTime
        color: "white"
      }
    }

    // filler
    Item {
      Layout.fillWidth: true
    }

    IconButton {
      Layout.preferredWidth: dp(50)
      Layout.preferredHeight: width
      Layout.rightMargin: dp(Theme.contentPadding)
      icon: IconType.playcircle
      size: dp(30)
      color: "white"
      selectedColor: Qt.darker(color, 1.1)
      onClicked: clickedNew()
    }
  }
}
