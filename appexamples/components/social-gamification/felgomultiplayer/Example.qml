import QtQuick 2.0
import Felgo 3.0

App {
  licenseKey: ""

  readonly property int felgoGameNetworkGameId: 285
  readonly property string felgoGameNetworkSecret: "AmazinglySecureGameSecret"
  readonly property string felgoAppKey: "dd7f1761-038c-4722-9f94-812d798cecfb"

  NavigationStack {
    id: navigationStack
    Page {
      id: apge
      title: "FelgoMultiplayer"

      FelgoGameNetwork {
        id: gameNetwork
        // Created in the Felgo Web Dashboard
        gameId: felgoGameNetworkGameId
        secret: felgoGameNetworkSecret
        multiplayerItem: myMultiplayer
      }

      FelgoMultiplayer {
        id: myMultiplayer
        appKey: felgoAppKey
        gameNetworkItem: gameNetwork
        playerCount: 2
      }

      MultiplayerView { // Adds the default multiplayer UI
        id: multiplayerView
        gameNetworkItem: myGameNetwork
      }
    }
  }
}
