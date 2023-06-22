import Felgo 4.0
import QtQuick 2.0


Rectangle {
  id: root

  readonly property var currentTrack: soundManager.currentTrack
  property bool isTrackFavorite: dataModel.isFavorite(root.currentTrack)

  width: parent.width
  height: dp(Theme.navigationTabBar.height)
  visible: root.currentTrack !== undefined

  color: Theme.navigationTabBar.backgroundColor

  MouseArea {
    anchors.fill: parent
    onClicked: actuallyPlayingModal.open()
  }

  Item {
    id: container
    anchors { top: parent.top; bottom: divider.top; left: parent.left; right: parent.right }

    AppImage {
      id: coverImage
      width: height
      height: parent.height

      source: Qt.resolvedUrl(dataModel.getCover(root.currentTrack))
    }

    Item {
      id: textContainer

      anchors {
        left: coverImage.right
        leftMargin: dp(10)
        right: favoriteIcon.left
        rightMargin: dp(2)
        verticalCenter: parent.verticalCenter
      }

      height: movingText.height
      clip: true

      AppText {
        id: movingText
        fontSize: 13

        text: {
          if (root.currentTrack === undefined) {
            return ""
          }

          var baseText = "<b>" + root.currentTrack.name + "</b>"

          if (root.currentTrack.album !== "" && root.currentTrack.album !== undefined) {
            baseText += " • " + root.currentTrack.album

            var author = dataModel.findAndGetFieldValue(root.currentTrack.album, "author")
            if (author !== "") {
              baseText += " • " + author
            }
          }

          if (root.currentTrack.author !== "" && root.currentTrack.author !== undefined) {
            baseText += " • " + root.currentTrack.author
          }

          return baseText
        }
      }

      NumberAnimation {
        target: movingText
        property: "x"
        duration: 6000
        from: textContainer.width
        to: - textContainer.width

        loops: Animation.Infinite
        running: true
      }
    }

    IconButton {
      id: favoriteIcon

      anchors { right: playStopButton.left; verticalCenter: parent.verticalCenter }

      color: Theme.textColor
      selectedColor: Theme.secondaryTextColor
      iconType: root.isTrackFavorite ? IconType.heart : IconType.hearto
      size: dp(20)

      onClicked: {
        if (root.isTrackFavorite) {
          dataModel.removeFromFavorites(root.currentTrack)
        } else {
          dataModel.addToFavorites(root.currentTrack)
        }

        root.isTrackFavorite = dataModel.isFavorite(root.currentTrack)
        logic.favoritesChanged(root.currentTrack["name"])
      }

      Connections {
        target: logic
        onFavoritesChanged: favorite => {
          if (favorite === root.currentTrack["name"]) {
            root.isTrackFavorite = dataModel.isFavorite(root.currentTrack)
          }
        }
      }
    }

    IconButton {
      id: playStopButton
      anchors { right: parent.right; rightMargin: dp(2); verticalCenter: parent.verticalCenter }

      color: Theme.textColor
      selectedColor: Theme.secondaryTextColor
      iconType: soundManager.isPlaying ? IconType.pause : IconType.play
      size: dp(20)

      onClicked: {
        if (soundManager.isPlaying) {
          soundManager.music.pause()
        } else {
          soundManager.music.play()
        }
      }
    }
  }

  Rectangle {
    id: divider
    anchors.bottom: parent.bottom
    width: parent.width
    height: dp(1)

    color: Theme.backgroundColor
  }
}
