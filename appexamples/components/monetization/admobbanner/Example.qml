import Felgo 3.0
import QtQuick 2.0


App {
  licenseKey: ""

  // Put your AdMob banner ad unit id
  readonly property string admobBannerAdUnitId: "ca-app-pub-9155324456588158/9913032020"

  NavigationStack {
    Page {
      id: page
      title: "AdMobBanner"

      Rectangle {
        anchors.centerIn: parent
        width: page.width * 0.75
        height: page.height * 0.75
        color: "salmon"

        AppText {
          fontSize: 30
          text: "Some useful content"
          anchors.centerIn: parent
        }
      }

      AdMobBanner {
        id: adMobBanner

        adUnitId: admobBannerAdUnitId
        banner: AdMobBanner.Smart

        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
        }
      }
    }
  }
}
