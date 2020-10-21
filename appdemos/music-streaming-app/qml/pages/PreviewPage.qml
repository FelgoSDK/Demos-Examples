import Felgo 3.0
import QtQuick 2.0
import QtGraphicalEffects 1.0


Page {
  id: root

  property bool isFavorite: dataModel.isFavorite(root.modelEntry)
  property var modelEntry: undefined

  backNavigationEnabled: true
  rightBarItem: IconButtonBarItem {
    icon: root.isFavorite ? IconType.heart : IconType.hearto

    onClicked: {
      if (root.isFavorite) {
        dataModel.removeFromFavorites(root.modelEntry)
      } else {
        dataModel.addToFavorites(root.modelEntry)
      }

      root.isFavorite = dataModel.isFavorite(root.modelEntry)
      logic.favoritesChanged(root.modelEntry["name"])
    }

    Connections {
      target: logic

      onFavoritesChanged: {
        if (favorite === root.modelEntry["name"]) {
          root.isFavorite = dataModel.isFavorite(root.modelEntry)
        }
      }
    }
  }

  title: modelEntry.name

  LinearGradient {
    anchors.fill: parent

    start: Qt.point(root.width * 0.5, 0)
    end: Qt.point(root.width * 0.5, root.height)
    gradient: Gradient {
      GradientStop { position: 0.0; color: "#404040"  }
      GradientStop { position: 1; color: "#121212" }
    }
  }

  AppFlickable {
    anchors {
      fill: parent
      bottomMargin: actuallyPlayingOverlay.visible ? actuallyPlayingOverlay.height : 0
    }

    contentHeight: contentColumn.height + contentColumn.anchors.topMargin

    Column {
      id: contentColumn

      anchors {
        top: parent.top
        topMargin: dp(60)
        horizontalCenter: parent.horizontalCenter
      }

      spacing: dp(15)

      AppImage {
        anchors.horizontalCenter: parent.horizontalCenter

        width: dp(150)
        height: width

        source: Qt.resolvedUrl(dataModel.getCover(modelEntry))
      }

      AppText {
        anchors.horizontalCenter: parent.horizontalCenter

        font {
          bold: true
          pixelSize: sp(25)
        }

        text: modelEntry.name
      }

      AppText {
        anchors.horizontalCenter: parent.horizontalCenter

        color: Theme.secondaryTextColor

        text: {
          if (modelEntry.type === "Song" || modelEntry.type === "Podcast" || modelEntry.type === "Album") {

            var author = ""
            if (modelEntry.album !== "" && modelEntry.album !== undefined) {
              author = dataModel.findAndGetFieldValue(modelEntry.album, "author")
            } else if (modelEntry.author !== "" && modelEntry.author !== undefined) {
              author = modelEntry.author
            }

            if (author !== "") {
              return modelEntry.type + " by " + author
            }

            if (modelEntry.tags.length > 0) {
              return modelEntry.type + " by " + modelEntry.tags[0]
            }
          }

          return modelEntry.type
        }
      }

      AppButton {
        anchors.horizontalCenter: parent.horizontalCenter

        height: dp(40)

        verticalPadding: dp(12)
        horizontalPadding: dp(45)

        radius: height / 2
        backgroundColor: Theme.tintColor
        textColor: Theme.textColor
        enabled: dataModel.relatedTracks(root.modelEntry).length > 0
        flat: false
        text: "SHUFFLE PLAY"
        textSize: sp(15)

        onClicked: {
          soundManager.shufflePlay(root.modelEntry)
          actuallyPlayingModal.open()
        }
      }
    }
  }
}
