import Felgo 4.0
import QtQuick 2.8
import Qt5Compat.GraphicalEffects
import "../components"
import "../model"

AppPage {
  id: root
  // let content run beneath status bar
  navigationBarTranslucency: 1
  useSafeArea: false

  rightBarItem: IconButtonBarItem {
    iconType: IconType.gear
    opacity: 1 - Math.min(1,flickable.contentY / dp(70))
    enabled: opacity > 0
    onClicked: root.navigationStack.push(settingsPageComponent)
  }

  Rectangle {
    z: 1
    width: parent.width
    height: Theme.statusBarHeight
    color: "black"
    opacity: Math.min(1,flickable.contentY / dp(300)) * 0.75
  }

  LinearGradient {
    anchors.fill: parent

    start: Qt.point(0, 0)
    end: Qt.point(root.width * 0.2, root.width * 0.7)
    gradient: Gradient {
      GradientStop { position: 0.0; color: "#404040" }
      GradientStop { position: 0.7; color: "#121212" }
    }
  }

  AppFlickable {
    id: flickable
    anchors.fill: parent
    anchors.bottomMargin: actuallyPlayingOverlay.visible ? actuallyPlayingOverlay.height : 0
    contentHeight: column.height

    Column {
      id: column

      topPadding: dp(16) + nativeUtils.safeAreaInsets.top
      width: parent.width
      spacing: dp(30)

      Column {
        id: recentlyPlayedColumn

        width: parent.width
        spacing: dp(20)
        visible: homePageModels.recentlyPlayedModel.count > 0

        AppText {
          text: "Recently played"
          font.bold: true
          fontSize: 24
          leftPadding: dp(Theme.contentPadding)
        }

        AppFlickable {
          width: parent.width
          height: contentHeight
          flickableDirection: Flickable.HorizontalFlick
          contentWidth: recentRow.width
          contentHeight: recentRow.height

          Row {
            id: recentRow
            leftPadding: dp(Theme.contentPadding)
            rightPadding: dp(Theme.contentPadding)
            spacing: dp(Theme.contentPadding)

            Repeater {
              model: homePageModels.recentlyPlayedModel

              HomePageListDelegate {
                onSelected: {
                  root.navigationStack.push(previewPageComponent, {"modelEntry": model})
                }
              }
            }
          }
        }
      }

      Column {
        id: madeForYouColumn

        width: parent.width
        spacing: dp(20)
        visible: homePageModels.madeForYouModel.count > 0

        AppText {
          text: "Made for you"
          font.bold: true
          fontSize: 24
          leftPadding: dp(Theme.contentPadding)
        }

        AppFlickable {
          width: parent.width
          height: contentHeight
          flickableDirection: Flickable.HorizontalFlick
          contentWidth: madeForYouRow.width
          contentHeight: madeForYouRow.height

          Row {
            id: madeForYouRow
            leftPadding: dp(Theme.contentPadding)
            rightPadding: dp(Theme.contentPadding)
            spacing: dp(Theme.contentPadding)

            Repeater {
              model: homePageModels.madeForYouModel

              HomePageListDelegate {
                onSelected: {
                  root.navigationStack.push(previewPageComponent, {"modelEntry": model})
                }
              }
            }
          }
        }
      }

      Column {
        id: popularColumn

        width: parent.width
        spacing: dp(20)
        visible: homePageModels.popularModel.count > 0

        AppText {
          text: "Popular"
          font.bold: true
          fontSize: 24
          leftPadding: dp(Theme.contentPadding)
        }


        AppFlickable {
          width: parent.width
          height: contentHeight
          flickableDirection: Flickable.HorizontalFlick
          contentWidth: popularRow.width
          contentHeight: popularRow.height

          Row {
            id: popularRow
            leftPadding: dp(Theme.contentPadding)
            rightPadding: dp(Theme.contentPadding)
            spacing: dp(Theme.contentPadding)

            Repeater {
              model: homePageModels.popularModel

              HomePageListDelegate {
                onSelected: {
                  root.navigationStack.push(previewPageComponent, {"modelEntry": model})
                }
              }
            }
          }
        }
      }

      Column {
        id: popSongsColumn

        width: parent.width
        spacing: dp(20)
        visible: homePageModels.popSongsModel.count > 0

        AppText {
          text: "Pop songs"
          font.bold: true
          fontSize: 24
          leftPadding: dp(Theme.contentPadding)
        }

        AppFlickable {
          width: parent.width
          height: contentHeight
          flickableDirection: Flickable.HorizontalFlick
          contentWidth: popSongsRow.width
          contentHeight: popSongsRow.height

          Row {
            id: popSongsRow
            leftPadding: dp(Theme.contentPadding)
            rightPadding: dp(Theme.contentPadding)
            spacing: dp(Theme.contentPadding)

            Repeater {
              model: homePageModels.popSongsModel

              HomePageListDelegate {
                onSelected: root.navigationStack.push(previewPageComponent, {"modelEntry": model})
              }
            }
          }
        }
      }

      Column {
        id: podcastsToTry

        width: parent.width
        spacing: dp(20)
        visible: homePageModels.podcastsToTryModel.count > 0

        AppText {
          text: "Podcasts to try"
          font.bold: true
          fontSize: 24
          leftPadding: dp(Theme.contentPadding)
        }


        AppFlickable {
          width: parent.width
          height: contentHeight
          flickableDirection: Flickable.HorizontalFlick
          contentWidth: podcastsToTryRow.width
          contentHeight: podcastsToTryRow.height

          Row {
            id: podcastsToTryRow
            leftPadding: dp(Theme.contentPadding)
            rightPadding: dp(Theme.contentPadding)
            spacing: dp(Theme.contentPadding)

            Repeater {
              model: homePageModels.podcastsToTryModel

              HomePageListDelegate {
                onSelected: root.navigationStack.push(previewPageComponent, {"modelEntry": model})
              }
            }
          }
        }
      }
    }
  }

  HomePageModels {
    id: homePageModels
  }
}
