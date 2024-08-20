import Felgo 4.0
import QtQuick 2.0


App {
  licenseKey: ""

  // Start currency
  property int token: 20

  NavigationStack {
    ListPage {
      title: "Chartboost"

      model: ListModel {
        ListElement {
          section: "Interstitial"
          name: "Load and show"
        }
        ListElement {
          section: "Interstitial"
          name: "Cache interstitial"
        }
        ListElement {
          section: "Interstitial"
          name: "Show Interstitial"
        }
        ListElement {
          section: "Rewarded Video"
          name: "Cache Video"
        }
        ListElement {
          section: "Rewarded Video"
          name: "Show Video"
        }
        ListElement {
          section: "More"
          name: "Load and show"
        }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          // Interstitial
          if (index === 0) {
            chartboost.showInterstitial()
          } else if (index === 1) {
            chartboost.cacheInterstitial(Chartboost.HomeScreenLocation)
          } else if(index === 2) {
            chartboost.showInterstitial(Chartboost.HomeScreenLocation)
          } else if(index === 3) {
            chartboost.cacheRewardedVideo(Chartboost.DefaultLocation)
          } else if (index === 4) {
            chartboost.showRewardedVideo(Chartboost.DefaultLocation)
          } else if (index === 5) {
            chartboost.showMoreApps(Chartboost.DefaultLocation)
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      Chartboost {
        id: chartboost
        property bool rewardReady: false

        readonly property string chartboostIosAppId: "53609edd89b0bb726b46c6e0"
        readonly property string chartboostAndroidAppId: "53609f3789b0bb72b4b95836"
        readonly property string chartboostIosAppSignature: "6fed94ffeaf6abb3d5aa85781e59fa2fb83354b8"
        readonly property string chartboostAndroidAppSignature: "c87b4e51a85b76a4bbe41ee880634fc9ae875ca8"

        appId: Theme.isIos ? chartboostIosAppId : chartboostAndroidAppId
        appSignature: Theme.isIos ? chartboostIosAppSignature : chartboostAndroidAppSignature

        onRewardedVideoCached: {
          rewardReady = true
          console.debug("Rewarded Video was cached!")
          NativeDialog.confirm("Rewarded Video Cached", "Rewarded Video is now cached.", function() { }, false)
        }

        onInterstitialCached: {
          console.log("Interstitial Cached for " + location + " or locationType: " + locationType)
          if (locationType === Chartboost.HomeScreenLocation) {
            console.log("Interstitial cached for HomeScreen")
          }
          NativeDialog.confirm("Interstitial Cached", "Interstitial is now cached.", function() { }, false)
        }

        // handle failed to load
        onRewardedVideoFailedToLoad: {
          NativeDialog.confirm("Rewarded Video Failed", "Rewarded Video failed to load.", function() { }, false)
        }

        onInterstitialFailedToLoad: {
          NativeDialog.confirm("Interstitial Failed", "Interstitial failed to load.", function() { }, false)
        }

        shouldRequestInterstitialsInFirstSession: true
      }
    }
  }
}
