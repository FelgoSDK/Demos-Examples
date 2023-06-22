import QtQuick 2.0
import Felgo 4.0


App {
  licenseKey: ""
  readonly property int felgoGameNetworkGameId: 285
  readonly property string felgoGameNetworkSecret: "AmazinglySecureGameSecret"

  NavigationStack {
    id: navigationStack
    ListPage {
      id: apge
      title: "FelgoGameNetwork"
      model: ListModel {
        ListElement { section: "Social View"; name: "Show Profile" }
        ListElement { section: "Social View"; name: "Show Leaderboard" }
        ListElement { section: "Social View"; name: "Show Chat" }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          if (index === 0) {
            navigationStack.push(socialView.profilePage)
          } else if (index === 1) {
            navigationStack.push(socialView.leaderboardPage)
          }
        }
      }

      FelgoGameNetwork {
        id: gameNetwork
        gameId: felgoGameNetworkGameId // Create your own gameId in the Web Dashboard
        secret: felgoGameNetworkSecret // https://cloud.felgo.com/games
      }

      SocialView {
        id: socialView
        gameNetworkItem: gameNetwork
        visible: false // Hide social view, as we show the pages on custom NavigationStacks instead
      }
    }
  }
}
