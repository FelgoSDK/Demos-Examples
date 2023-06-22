import Felgo 4.0
import QtQuick 2.8
import QtQuick.Controls 2.0 as Controls
import Qt5Compat.GraphicalEffects
import "../components"


AppModal {
  id: root

  readonly property var currentTrack: soundManager.currentTrack
  property bool isTrackFavorite: dataModel.isFavorite(root.currentTrack)

  pushBackContent: navigation
  overlayColor: "#fff"
  overlayOpacity: 0.05

  onClosed: flickable.contentY = 0

  NavigationStack {
    AppPage {
      navigationBarTranslucency: 1
      useSafeArea: false

      leftBarItem: IconButtonBarItem {
        iconType: IconType.chevrondown

        onClicked: root.close()
      }

      titleItem: Column {
        anchors.centerIn: parent
        spacing: dp(2)

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          font.capitalization: Font.AllUppercase
          fontSize: 11
          text: {
            if (root.currentTrack === undefined) {
              return ""
            }

            if (root.currentTrack.album !== "" && root.currentTrack.album !== undefined) {
              return "Playing from album"
            }

            return "Playing " + root.currentTrack.type
          }
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter

          font.bold: true
          font.capitalization: Font.AllUppercase
          fontSize: 14
          text: {
            if (root.currentTrack === undefined) {
              return ""
            }
            if (root.currentTrack.album !== "" && root.currentTrack.album !== undefined) {
              return root.currentTrack.album
            }
            return ""
          }
        }
      }


      LinearGradient {
        anchors.fill: parent
        anchors.topMargin: Theme.isAndroid ? - Theme.statusBarHeight : 0

        start: Qt.point(root.width * 0.5, 0)
        end: Qt.point(root.width * 0.5, root.height)
        gradient: Gradient {
          GradientStop {
            position: 0.0
            color: {
              if (root.currentTrack === undefined) {
                return "#404040"
              }

              return !!root.currentTrack.color ? root.currentTrack.color : "#404040"
            }
          }
          GradientStop { position: 1; color: "#121212" }
        }
      }

      AppFlickable {
        id: flickable
        anchors.topMargin: dp(5)
        anchors.fill: parent

        contentHeight: contentColumn.height
        interactive: contentHeight > height

        Column {
          id: contentColumn
          width: parent.width
          topPadding: dp(Theme.navigationBar.height) + dp(Theme.contentPadding)*2
          bottomPadding: dp(Theme.contentPadding)*2

          AppImage {
            id: coverImage

            anchors.horizontalCenter: parent.horizontalCenter
            width: height
            height: Math.min(parent.width - dp(Theme.contentPadding)*4, root.height * 0.7 - trackDetailsContainer.height - dp(40))

            source: Qt.resolvedUrl(dataModel.getCover(root.currentTrack))
          }

          Item {
            width: 1
            height: dp(40)
          } // spacer

          Column {
            id: trackDetailsContainer
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - dp(Theme.contentPadding)*4
            spacing: dp(5)

            AppText {
              font.bold: true
              fontSize: 20
              text: !!root.currentTrack ? root.currentTrack.name : ""
            }

            AppText {
              color: Theme.secondaryTextColor
              fontSize: 16
              text: {
                if (root.currentTrack === undefined) {
                  return ""
                }

                if (root.currentTrack.album !== "" && root.currentTrack.album !== undefined) {
                  return dataModel.findAndGetFieldValue(root.currentTrack.album, "author")
                }

                return root.currentTrack.author
              }
            }

            Item {
              id: progressBarContainer

              width: parent.width
              height: dp(50)

              AppText {
                id: timePassedText
                anchors { left: parent.left; bottom: parent.bottom }

                fontSize: 11
                text: root.formatTime(soundManager.passedTime)

                onTextChanged: {
                  if (timePassedText.text == durationTimeText.text && durationTimeText.text != "0:00") {
                    soundManager.playNextTrack()
                  }
                }
              }

              AppText {
                id: durationTimeText
                anchors { right: parent.right; bottom: parent.bottom }

                fontSize: 11
                text: root.formatTime(parseInt(!!root.currentTrack ? root.currentTrack.duration : 0)) // mocked field
              }

              Controls.ProgressBar {
                id: progressBar
                anchors { bottom: timePassedText.top; bottomMargin: dp(8) }
                width: parent.width
                height: dp(5)

                from: 0
                to: parseInt(!!root.currentTrack ? root.currentTrack.duration : 0) // mocked field
                value: soundManager.passedTime // mocked field

                clip: true
                background: Rectangle {
                  anchors.fill: progressBar
                  color: "#828282"
                  radius: height / 2
                }

                contentItem: Rectangle {
                  id: bar
                  width: progressBar.visualPosition * parent.width
                  height: parent.height
                  radius: height / 2
                }
              }
            }

            Item {
              id: buttonsContainer
              width: parent.width
              height: dp(65)

              Row {
                id: playButtonsRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: dp(5)

                IconButton {
                  size: dp(25)
                  anchors.verticalCenter: parent.verticalCenter
                  enabled: soundManager.currentTrackIndex > 0 && soundManager.tracks.length > 1

                  color: Theme.textColor
                  disabledColor: Theme.secondaryTextColor
                  selectedColor: disabledColor
                  iconType: IconType.stepbackward

                  onClicked: soundManager.playPreviousTrack()
                }

                Rectangle {
                  width: dp(65)
                  height: width
                  color: playButtonMa.pressed ? Theme.secondaryTextColor : Theme.textColor
                  radius: height / 2

                  AppIcon {
                    anchors.centerIn: parent

                    color: Theme.backgroundColor
                    iconType: soundManager.isPlaying ? IconType.pause : IconType.play
                    size: dp(25)
                  }

                  MouseArea {
                    id: playButtonMa
                    anchors.fill: parent
                    onClicked: {
                      if (soundManager.isPlaying) {
                        soundManager.pause()
                      } else {
                        soundManager.play()
                      }
                    }
                  }
                }

                IconButton {
                  anchors.verticalCenter: parent.verticalCenter

                  iconType: IconType.stepforward
                  color: Theme.textColor
                  selectedColor: Theme.secondaryTextColor
                  size: dp(25)

                  onClicked: soundManager.playNextTrack()
                }
              } // buttons row

              IconButton {
                anchors { left: parent.left; verticalCenter: parent.verticalCenter }

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
              } // favorite button

              IconButton {
                anchors { right: parent.right; verticalCenter: parent.verticalCenter }

                color: Theme.textColor
                disabledColor: Theme.secondaryTextColor
                selectedColor: Theme.secondaryTextColor
                enabled: !!soundManager.tracks ? soundManager.tracks.length > 0 : false
                iconType: IconType.stop
                size: dp(20)

                onClicked: {
                  soundManager.hideCurrentTrack()
                }
              } // hide track button
            } // buttons container
          } // track details column

          Item {
            width: 1
            height: dp(20)
          } // spacer

        } // content column
      } // flickable
    } // page
  } // navigation stack

  function formatTime(milliseconds) {
    var asSeconds = Math.floor(milliseconds / 1000)
    var minutes = Math.floor(asSeconds / 60)
    var seconds = (asSeconds - minutes * 60).toString()
    if (seconds.length === 1) {
      seconds = "0" + seconds
    }

    return minutes + ":" + seconds
  }
}
