import Felgo
import QtQuick
import "../../common"
import "../../details"

Column {
  property real descriptionTextMaxWidth

  Rectangle {
    id: wrapper
    width: parent.width
    height: wrapper.width
    color: eventDetails.pineColor

    AppImage {
      id: bannerImage
      width: parent.width
      anchors.bottom: parent.bottom
      height: parent.width
      fillMode: AppImage.PreserveAspectFit
      source: "../../../assets/big-logo.png"
      opacity: 0.8
      MouseArea {
        anchors.fill: parent
        onClicked: NativeUtils.openUrl("https://www.qt.io/qt-world-summit-2023")
      }
    }

      AppText {
        width: parent.width - dp(Theme.contentPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: AppText.AlignHCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(4)
        color: "white"
        text: eventDetails.shortInfo
        font.pixelSize: sp(17)
      }
  }

  Rectangle {
    width: parent.width
    color: eventDetails.pineColor
    height: qtIntroCol.height

    Column {
      id: qtIntroCol
      width: parent.width
      topPadding: dp(Theme.contentPadding)
      bottomPadding: dp(15)

      AppText {
        width: descriptionTextMaxWidth
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: sp(17)
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        textFormat: Text.StyledText
        linkColor: eventDetails.neonColor
        text: "The Future of Digital Experiences"
      }

      AppButton {
        anchors.horizontalCenter: parent.horizontalCenter
        flat: true
        verticalMargin: dp(Theme.contentPadding)
        innerSpacing: dp(Theme.contentPadding)
        iconLeft: IconType.globe
        iconSize: sp(16)
        textSize: sp(14)
        fontBold: true
        fontCapitalization: Font.AllLowercase
        text: "www.qt.io/qt-world-summit-2023"
        onClicked: NativeUtils.openUrl("https://www.qt.io/qt-world-summit-2023")
      }
    }
  }
}
