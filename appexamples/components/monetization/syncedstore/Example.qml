import Felgo
import QtQuick


App {
  licenseKey: ""

  property string soomlaSecret: "<your-game-secret>"
  property string soomlaAndroidPublicKey: "<android-public-key>"
  property string creditsCurrencyItemId: "net.vplay.demos.PluginDemo.credits"
  property string creditsPackItemId: "net.vplay.demos.PluginDemo.creditspack"
  property string goodieItemId: "net.vplay.demos.PluginDemo.goodie"
  property string noAdsItemId: "net.vplay.demos.PluginDemo.noads"

  // Start currency
  property int token: 20

  NavigationStack {
    ListPage {

      title: "Soomla Plugin"

      listView.anchors.bottomMargin: annoyingAd.visible ? annoyingAd.height : 0

      model: ListModel {
        ListElement {
          section: "Credits"
          name: "Buy 10 credits"
        }
        ListElement {
          section: "Goodies"
          name: "Buy 1 goodie"
        }
        ListElement {
          section: "Product"
          name: "Give Ad-Free Upgrade"
        }
        ListElement {
          section: "Product"
          name: "Take Ad-Free Upgrade"
        }
        ListElement {
          section: "Product"
          name: "Buy Ad-Free Upgrade"
        }
        ListElement {
          section: "Store"
          name: "Restore Purchases"
        }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          switch (index) {
          case 0: store.buyItem(creditsPack.itemId); break;
          case 1: store.buyItem(goodieGood.itemId); break;
          case 2: store.giveItem(noadsGood.itemId); break;
          case 3: store.takeItem(noadsGood.itemId); break;
          case 4: store.buyItem(noadsGood.itemId); break;
          case 5: store.restoreAllTransactions(); break;
          default: console.error("Unknown index", index); break;
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      // This rectangle represents an ad banner within your app
      Rectangle {
        id: annoyingAd
        anchors.bottom: parent.bottom
        width: parent.width
        height: dp(50)

        // Just one line for handling visibility of the ad banner, you can use property binding for this!
        visible: !noadsGood.purchased

        SequentialAnimation on color {
          loops: Animation.Infinite
          ColorAnimation { from: "green"; to: "red"; duration: 300 }
          ColorAnimation { from: "red"; to: "green"; duration: 300 }
        }

        Text {
          text: "Annoying Ad"
          font.pixelSize: dp(20)
          color: "white"
          anchors.centerIn: parent
        }
      }

      FelgoGameNetwork {
        id: myGameNetwork

        // Other gameNetwork code here
      }

      SyncedStore {
        id: store
        gameNetworkItem: myGameNetwork

        version: 1
        secret: soomlaSecret
        androidPublicKey: soomlaAndroidPublicKey

        // Virtual currencies within the app or game
        currencies: [
          Currency {
            id: creditsCurrency
            itemId: creditsCurrencyItemId
            name: "Credits"
          }
        ]

        // Purchasable credit packs
        currencyPacks: [
          CurrencyPack {
            id: creditsPack
            itemId: creditsPackItemId
            name: "10 Credits"
            description: "Buy 10 Credits"
            currencyId: creditsCurrency.itemId
            currencyAmount: 10
            purchaseType: StorePurchase {
              id: gold10Purchase
              productId: creditsPack.itemId
              price: 0.99
            }
          }
        ]

        // Goods contain either single-use, single-use-pack or lifetime goods
        goods: [
          // A goodie costs 3 credits (virtual currency that can be purschased with an in-app purchase)
          SingleUseGood {
            id: goodieGood
            itemId: goodieItemId
            name: "Goodie"
            description: "A tasty goodie"
            purchaseType: VirtualPurchase {
              itemId: creditsCurrency.itemId
              amount: 3
            }
          },
          // Life-time goods can be restored from the store
          LifetimeGood {
            id: noadsGood
            itemId: noAdsItemId
            name: "No Ads"
            description: "Buy this item to remove the app banner"
            purchaseType: StorePurchase {
              id: noAdPurchase
              productId: noadsGood.itemId
              price: 2.99
            }
          }
        ]

        onItemPurchased: {
          console.debug("Purchases item:", itemId)
          NativeDialog.confirm("Info", "Successfully bought: " + itemId, null, false)
        }

        onInsufficientFundsError: {
          console.debug("Insufficient funds for purchasing item")
          NativeDialog.confirm("Error",
                               "Insufficient credits for buying a goodie, get more credits now?",
                               function(ok) {
                                 if (ok) {
                                   // Trigger credits purchase right from dialog
                                   store.buyItem(creditsPack.itemId)
                                 }
                               }, true)
        }

        onRestoreAllTransactionsFinished: {
          console.debug("Purchases restored with success:", success)
        }
      }
    }
  }
}
