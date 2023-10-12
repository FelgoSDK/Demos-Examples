import Felgo 3.0
import QtQuick 2.0

App {
  licenseKey: ""

  // Put your AdMob banner ad unit id
  readonly property string admobBannerAdUnitId: "ca-app-pub-9155324456588158/9913032020"

  NavigationStack {
    FlickablePage {
      title: "Admob Banner"
      flickable.contentHeight: contentColumn.height

      Column {
        id: contentColumn
        width: parent.width

        AdMobBannerNative {
          adUnitId: admobBannerAdUnitId
          banner: AdMobBannerNative.BannerType.Smart
        }

        Repeater {
          model: 100
          delegate: SimpleRow { text: "Item #" + index }
        }
      }
    }
  }
}
