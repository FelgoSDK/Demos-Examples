import Felgo
import QtQuick


Item {
  id: root

  property alias title: titleText.text
  property alias value: valueText.text

  width: parent.width / 2
  height: parent.height / 2

  states: [
    State {
      name: "feed"
      PropertyChanges {
        target: titleText
        font.capitalization: Font.MixedCase
      }
      PropertyChanges {
        target: root
        width: Math.max(titleText.contentWidth, valueText.contentWidth) + 2 * dp(Theme.contentPadding)
      }
    }
  ]

  Column {
    anchors.centerIn: parent
    spacing: dp(10)

    AppText {
      id: titleText

      anchors.horizontalCenter: parent.horizontalCenter

      font.capitalization: Font.AllUppercase
      fontSize: 12
    }

    AppText {
      id: valueText

      anchors.horizontalCenter: parent.horizontalCenter

      fontSize: 16
    }
  }
}
