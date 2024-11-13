import QtQuick
import Felgo

import "../../details"

Column {

  id: item
  spacing: dp(Theme.navigationBar.defaultBarItemPadding)

  SimpleSection {
    title: "At the venue"
  }

  Row {
    spacing: dp(10)
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    AppIcon {
      iconType: IconType.umbrella
      color: Theme.colors.tintColor
      anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
      textFormat: AppText.StyledText
      text: "<b>Cloakrooms</b>"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  AppText {
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    wrapMode: AppText.WordWrap
    textFormat: AppText.StyledText
    linkColor: Theme.tintColor
    text: venueDetails.cloakrooms
  }

  Row {
    spacing: dp(10)
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    AppIcon {
      iconType: IconType.infocircle
      color: Theme.colors.tintColor
      anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
      textFormat: AppText.StyledText
      text: "<b>Info Desk</b>"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  AppText {
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    wrapMode: AppText.WordWrap
    textFormat: AppText.StyledText
    linkColor: Theme.tintColor
    text: venueDetails.infoDesk
  }

  Row {
    spacing: dp(10)
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    AppIcon {
      iconType: IconType.gift
      color: Theme.colors.tintColor
      anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
      textFormat: AppText.StyledText
      text: "<b>Swag Pick-Up</b>"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  AppText {
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    wrapMode: AppText.WordWrap
    textFormat: AppText.StyledText
    linkColor: Theme.tintColor
    text: venueDetails.swagPickUp
  }

  Row {
    spacing: dp(10)
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    AppIcon {
      iconType: IconType.rocket
      color: Theme.colors.tintColor
      anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
      textFormat: AppText.StyledText
      text: "<b>Demo Area</b>"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  AppText {
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    wrapMode: AppText.WordWrap
    textFormat: AppText.StyledText
    linkColor: Theme.tintColor
    text: venueDetails.demoArea
  }

  Row {
    spacing: dp(10)
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    AppIcon {
      iconType: IconType.wifi
      color: Theme.colors.tintColor
      anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
      textFormat: AppText.StyledText
      text: "<b>Wi-Fi</b>"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  AppText {
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    wrapMode: AppText.WordWrap
    textFormat: AppText.StyledText
    linkColor: Theme.tintColor
    text: venueDetails.wifi
  }

  Row {
    spacing: dp(10)
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    AppIcon {
      iconType: IconType.gamepad
      color: Theme.colors.tintColor
      anchors.verticalCenter: parent.verticalCenter
    }
    AppText {
      textFormat: AppText.StyledText
      text: "<b>Afterwork & Party</b>"
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  AppText {
    width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
    anchors.horizontalCenter: parent.horizontalCenter
    wrapMode: AppText.WordWrap
    textFormat: AppText.StyledText
    linkColor: Theme.tintColor
    text: venueDetails.afterwork
  }

}
