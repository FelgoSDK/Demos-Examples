import Felgo
import QtQuick
import "../common"
import "../details"

ListPage {
  id: morePage
  title: "More"
  backgroundColor: Theme.colors.secondaryBackgroundColor

  property string ratingUrl: system.isPlatform(System.IOS) ? publisherDetails.ratingUrls.ios :
                             system.isPlatform(System.Android) ? publisherDetails.ratingUrls.android :
                             ""

  // Note: no need to e.g. use JsonListModel here, this model menu items won't change while using the app
  property var modelConfig: app.tablet ? [
                        { text: "About this app", section: "More", page: Qt.resolvedUrl("AboutFelgoPage.qml"), icon: IconType.home },
                        { text: "Rate this app", section: "More", special: "rate", icon: IconType.star, visible: morePage.ratingUrl !== "" },
                        { text: "Share this app", section: "More", special: "share", icon: IconType.share, visible: morePage.ratingUrl !== "" }
                      ] : [
                        { text: "Venue", section: "General", page: Qt.resolvedUrl("VenuePage.qml"), icon: IconType.building },
                        { text: "Speakers", section: "General", page: Qt.resolvedUrl("SpeakersPage.qml"), icon: IconType.microphone },
                        { text: "Settings", section: "General", page: Qt.resolvedUrl("SettingsPage.qml"), icon: IconType.gears },
                        { text: "About this app", section: "More", page: Qt.resolvedUrl("AboutFelgoPage.qml"), icon: IconType.home },
                        { text: "Rate this app", section: "More", special: "rate", icon: IconType.star, visible: morePage.ratingUrl !== "" },
                        { text: "Share this app", section: "More", special: "share", icon: IconType.share, visible: morePage.ratingUrl !== "" }
                      ]
  model: modelConfig.filter(entry => entry.visible !== false)

  section.property: "section"

  delegate: AppListItem {
    insetStyle: Theme.isIos
    leftItem: Item {
      width: dp(26)
      height: parent.height
      AppIcon {
        iconType: modelData.icon
        size: dp(17)
        anchors.centerIn: parent
      }
    }
    text: modelData.text
    visible: modelData.visible !== false
    onSelected: {
      if(modelData.special) {
        if(modelData.special === "rate") {
          logic.setFeedBackSent(true)
          nativeUtils.openUrl(morePage.ratingUrl)
        } else if(modelData.special === "share") {
          nativeUtils.share("Check out the " + eventDetails.name + " Conference App!", morePage.ratingUrl)
        }
      } else {
        morePage.navigationStack.popAllExceptFirstAndPush(modelData.page)
      }
    }
  }
}


