import Felgo
import QtQuick

import "../details"
import "./components"

FlickablePage {
  id: page
  title: "Venue"

  flickable.contentWidth: page.width
  flickable.contentHeight: contentCol.height

  function openLocation() {
    if (Theme.isIos){
      Qt.openUrlExternally("http://maps.apple.com/?q=" + venueDetails.fullName)
    } else {
      Qt.openUrlExternally("geo:0,0?q=" + venueDetails.geo.latitude + "," + venueDetails.geo.longitude)
    }
  }

  Column {
    id: contentCol
    width: parent.width

    Item {
      width: parent.width
      height: landscape ? dp(300) : img.height
      clip: true

      AppImage {
        id: img
        width: parent.width
        height: width / sourceSize.width * sourceSize.height
        fillMode: AppImage.PreserveAspectFit
        source: "../../assets/venue_photo.jpg"
        anchors.bottom: parent.bottom
      }
    }

    Item {
      width: parent.width
      height: addressCol.height + dp(Theme.navigationBar.defaultBarItemPadding) * 2
      Column {
        id: addressCol
        width: parent.width
        anchors.centerIn: parent
        spacing: dp(Theme.navigationBar.defaultBarItemPadding)
        Item {
          width: parent.width
          height: 1
          visible: Theme.isIos
        }
        Column {
          width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
          anchors.horizontalCenter: parent.horizontalCenter
          AppText {
            width: parent.width
            wrapMode: AppText.WordWrap
            text: venueDetails.name
          }
          AppText {
            width: parent.width
            wrapMode: AppText.WordWrap
            color: Theme.secondaryTextColor
            font.pixelSize: sp(13)
            text: venueDetails.addressLine1
          }
          AppText {
            width: parent.width
            wrapMode: AppText.WordWrap
            color: Theme.secondaryTextColor
            font.pixelSize: sp(13)
            text: venueDetails.addressLine2
          }
        }

        AppButton {
          text: "Plan Route"
          width: Math.min(parent.width/2, dp(200))
          anchors.horizontalCenter: parent.horizontalCenter
          flat: false
          onClicked: {
            openLocation()
          }
        }
      }
      Rectangle {
        anchors.top: parent.top
        width: parent.width
        color: Theme.listItem.dividerColor
        height: px(1)
      }
      Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        color: Theme.listItem.dividerColor
        height: px(1)
      }
    }

    AppImage {
      width: parent.width
      height: imgHeight
      fillMode: AppImage.PreserveAspectCrop
      visible: status === Image.Ready || status === Image.Loading
      property int imgWidth: Math.min(1000,Math.max(320,width))
      property int imgHeight: Math.min(1000,Math.max(240,height))
      source: "../../assets/venue_map.png"

      RippleMouseArea {
        anchors.fill: parent
        circularBackground: false
        onClicked: {
          openLocation()
        }
      }
    }

    Column {
      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: dp(Theme.navigationBar.defaultBarItemPadding)

      Item {
        width: parent.width
        height: 1
      }

      AppText {
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: AppText.WordWrap
        textFormat: AppText.StyledText
        linkColor: Theme.tintColor
        text: "<b>" + venueDetails.city + ", one of the biggest tech hubs in Europe will host the " + eventDetails.genericName +
              " again this year.</b>"
      }

      SimpleSection {
        title: "About the bcc"
      }

      AppText {
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: AppText.WordWrap
        textFormat: AppText.StyledText
        linkColor: Theme.tintColor
        text: venueDetails.description
      }

      SimpleSection {
        title: "Get to the venue"
      }

      Row {
        spacing: dp(10)
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        AppIcon {
          iconType: IconType.taxi
          color: Theme.colors.tintColor
          anchors.verticalCenter: parent.verticalCenter
        }
        AppText {
          textFormat: AppText.StyledText
          text: "<b>Travel by Car</b>"
          anchors.verticalCenter: parent.verticalCenter
        }
      }

      AppText {
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: AppText.WordWrap
        textFormat: AppText.StyledText
        linkColor: Theme.tintColor
        text: venueDetails.travelByCar
      }

      Row {
        spacing: dp(10)
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        AppIcon {
          iconType: IconType.bus
          color: Theme.colors.tintColor
          anchors.verticalCenter: parent.verticalCenter
        }
        AppText {
          textFormat: AppText.StyledText
          text: "<b>Travel by Public Transport</b>"
          anchors.verticalCenter: parent.verticalCenter
        }
      }

      AppText {
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.horizontalCenter: parent.horizontalCenter
        wrapMode: AppText.WordWrap
        textFormat: AppText.StyledText
        linkColor: Theme.tintColor
        text: venueDetails.travelByPublicTransport
      }

      AtTheVenueInfoItem {
        width: parent.width
      }

      Item {
        width: parent.width
        height: 1
      }
    }
  }
}
