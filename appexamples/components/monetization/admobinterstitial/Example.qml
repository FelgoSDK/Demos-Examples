import Felgo 3.0
import QtQuick 2.0


App {
  licenseKey: ""

  NavigationStack {
    Page {
      id: page
      title: "AdMobInterstitial"

      AppButton {
        anchors.centerIn: parent
        text: "Show AdMobInterstitial"
        flat: false
        textSize: sp(20)
        onClicked: {
          ad.showInterstitialIfLoaded()
        }
      }

      AdMobInterstitial {
        id: ad
        // Interstitial test ad by AdMob
        adUnitId: "ca-app-pub-3940256099942544/1033173712"

        onPluginLoaded: {
          loadInterstitial()
        }
      }
    }
  }
}
