import Felgo
import QtQuick
import "../../common"
import "../../details"

Column {
  id: root
  property real descriptionTextMaxWidth

  property color backgroundColor: appDetails.darkMode ? Theme.backgroundColor : Theme.secondaryBackgroundColor

  Column {
    width: parent.width

    Rectangle {
      width: parent.width
      height: dp(220)
      color: root.backgroundColor

      Column {
        anchors.centerIn: parent
        spacing: dp(10)

        AppImage {
          source: appDetails.darkMode ? "../../../assets/felgo.png" : "../../../assets/felgo_black.png"
          width: dp(150)
          fillMode: Image.PreserveAspectFit
          anchors.horizontalCenter: parent.horizontalCenter
        }

        // Spacer
        Item {
          width: parent.width
          height: px(1)
        }

        AppText {
          text: "WE MADE THIS APP FOR YOU!"
          font.bold: true
          font.pixelSize: sp(14)
          anchors.horizontalCenter: parent.horizontalCenter
        }

        AppText {
          text: "And there is <b>much more</b> we can do."
          font.pixelSize: sp(13)
          anchors.horizontalCenter: parent.horizontalCenter
        }

        // Spacer
        Item {
          width: parent.width
          height: dp(1)
        }

        Row {
          spacing: dp(20)
          anchors.horizontalCenter: parent.horizontalCenter
          AppImage {
            id: techPartnerImg
            source: appDetails.darkMode ? "../../../assets/qt_tech_partner_white.png" : "../../../assets/qt_tech_partner_black.png"
            width: dp(150)
            fillMode: Image.PreserveAspectFit
          }
          AppImage {
            source: appDetails.darkMode ? "../../../assets/qt_service_partner_white.png" : "../../../assets/qt_service_partner_black.png"
            height: techPartnerImg.height
            fillMode: Image.PreserveAspectFit
          }
        }
      }
      MouseArea {
        anchors.fill: parent
        onClicked: {
          utils.confirmOpenUrl(publisherDetails.offerUrl)
        }
      }
    }
  }
}
