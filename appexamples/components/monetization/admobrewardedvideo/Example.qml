import Felgo 3.0
import QtQuick 2.0


App {
  licenseKey: ""

  // Start currency
  property int token: 20

  NavigationStack {
    Page {
      title: "AdMobRewardedVideo"
      // We show the token in the navigation bar
      rightBarItem: NavigationBarItem {
        AppText {
          anchors.verticalCenter: parent.verticalCenter
          text: token
          color: Theme.isIos ? Theme.tintColor : "white"
          font.bold: true
        }
      }

      AdMobRewardedVideo {
        id: myRewardedVideo

        // Test ad for rewarded videos create your own from the AdMob Backend
        adUnitId: system.isPlatform(System.IOS)
                  ? "ca-app-pub-3940256099942544/1712485313"
                  : "ca-app-pub-3940256099942544/5224354917"

        // If the video is fully watched, we add 10 token
        onRewardedVideoRewarded: {
          token += 10
        }

        onRewardedVideoClosed: {
          // Load a new video every time it got shown, to give the user a fresh ad
          loadRewardedVideo()
        }

        // Load interstitial at app start to cache it
        onPluginLoaded: {
          loadRewardedVideo()
        }
      }

      AppButton {
        anchors.centerIn: parent
        flat: false
        textSize: sp(20)
        text: "Decrease token count by 1"
        onClicked: {
          // Decrease token by 1
          token--

          if (token < 10) {
            // Show the new video if user is below 10 token
            myRewardedVideo.showRewardedVideoIfLoaded()
          }
        }
      }
    }
  }
}
