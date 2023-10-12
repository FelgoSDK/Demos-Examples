import Felgo 3.0
import QtQuick 2.0
import "../common"

ListPage {
  id: morePage
  title: "More"

  // Note: no need to e.g. use JsonListModel here, this model menu items won't change while using the app
  model: [
    { text: "Business Meet", section: "Social", page: socialViewItem.businessMeetPage },
    { text: "Your Profile", section: "Social", page: socialViewItem.profilePage },
    { text: "Chat", section: "Social", page: socialViewItem.inboxPage },
    { text: "Leaderboard", section: "Social", page: socialViewItem.leaderboardPage },
    { text: "Tracks", section: "General", page: Qt.resolvedUrl("TracksPage.qml") },
    { text: "Venue", section: "General", page: Qt.resolvedUrl("VenuePage.qml") },
//    { text: "QR Contacts", section: "General", page: Qt.resolvedUrl("ContactsPage.qml")},
    { text: "Settings", section: "General", page: Qt.resolvedUrl("SettingsPage.qml") },
//    { text: "About Felgo", section: "General", page: Qt.resolvedUrl("AboutFelgoPage.qml") }
    { text: "Rate this App", section: "More", special: "rate", icon: IconType.star },
    { text: "Share this App", section: "More", special: "share", icon: IconType.share }

  ]

  section.property: "section"

  // open configured page when clicked
  onItemSelected: {
    if(model[index].special) {
      if(model[index].special === "rate") {
        amplitude.logEvent("RateInStore")
        logic.setFeedBackSent(true)
        nativeUtils.openUrl(ratingUrl)
      } else if(model[index].special === "share") {
        amplitude.logEvent("Share Button Pressed")
        nativeUtils.share("Check out the Qt World Summit 2019 Conference App!", "https://felgo.com/qws-conference-in-app-2019")
      }
    } else {
      morePage.navigationStack.popAllExceptFirstAndPush(model[index].page)
    }
  }



//  SimpleRow {
//    iconSource: IconType.star
//    text: qsTr("Rate this App")
//    //        style: StyleSimpleRow {
//    //          textColor: "#444"
//    //        }
//    style.showDisclosure: false
//    onSelected: {
//      analytics.logEvent("Rate Button Pressed")
//      if(system.isPlatform(System.IOS)) {
//        // old link format no longer working
//        //          nativeUtils.openUrl("itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1157319191&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&action=write-review")
//        nativeUtils.openUrl("https://itunes.apple.com/us/app/appName/id1438432642?mt=8&action=write-review")
//      } else {
//        nativeUtils.openUrl("https://play.google.com/store/apps/details?id=net.vplay.demos.apps.weatherapp")
//      }
//    }
//  }

//  SimpleRow {
//    iconSource: IconType.share
//    text: qsTr("Share with Friends")

//    style.showDisclosure: false
//    onSelected: {
//      analytics.logEvent("Share Button Pressed")
//      nativeUtils.share("Check out WTR - Weather Pro, the best Weather App!", "https://felgo.com/weather-app-mobile/")
//    }
//  }
}


