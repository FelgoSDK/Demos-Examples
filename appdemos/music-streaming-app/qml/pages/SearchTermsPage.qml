import Felgo 3.0
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../components"


Page {
  id: root

  signal searchRequested(string term)

  navigationBarHidden: true
  useSafeArea: false

  AppFlickable {
    id: flickable

    anchors.fill: parent
    anchors.topMargin: Theme.statusBarHeight
    anchors.bottomMargin: actuallyPlayingOverlay.visible ? actuallyPlayingOverlay.height : 0
    contentHeight: column.height
    contentWidth: parent.width

    Column {
      id: column
      width: parent.width
      spacing: dp(15)

      Item {
        id: titleContainer
        width: parent.width
        height: dp(150)

        AppText {
          anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: dp(20)
          }

          font {
            bold: true
            pixelSize: sp(40)
          }

          text: "Search"
        }
      }

      Item {
        width: parent.width
        height: mockedSearchBar.height
        z: 1000

        MockedSearchBar {
          id: mockedSearchBar

          y: flickable.contentY > titleContainer.height + dp(15) ? flickable.contentY - (titleContainer.height + dp(15)) : 0

          onClicked: {
            root.searchRequested("")
          }
        }
      }

      AppText {
        id: browseLabel

        anchors {
          left: parent.left
          leftMargin: parent.width * 0.05
        }

        font.bold: true
        text: qsTr("Browse all")
      }

      Grid {
        width: parent.width
        columns: 2

        Repeater {
          model: ListModel {
            ListElement {
              term: "Podcast"
              tileColor: "#f59a25"
            }
            ListElement {
              term: "New Releases"
              tileColor: "#768d9b"
            }
            ListElement {
              term: "Hip-Hop"
              tileColor: "#4a927e"
            }
            ListElement {
              term: "Pop"
              tileColor: "#ff6537"
            }
            ListElement {
              term: "Rock"
              tileColor: "#f135a3"
            }
            ListElement {
              term: "Gaming"
              tileColor: "#f14735"
            }
            ListElement {
              term: "Wellness"
              tileColor: "#f59a25"
            }
            ListElement {
              term: "Chill"
              tileColor: "#768d9b"
            }
            ListElement {
              term: "Party"
              tileColor: "#4a927e"
            }
            ListElement {
              term: "Workout"
              tileColor: "#ff6537"
            }
            ListElement {
              term: "Podcasts"
              tileColor: "#f59a25"
            }
            ListElement {
              term: "New Releases"
              tileColor: "#768d9b"
            }
            ListElement {
              term: "Hip-Hop"
              tileColor: "#4a927e"
            }
            ListElement {
              term: "Pop"
              tileColor: "#ff6537"
            }
            ListElement {
              term: "Rock"
              tileColor: "#f135a3"
            }
            ListElement {
              term: "Gaming"
              tileColor: "#f14735"
            }
            ListElement {
              term: "Wellness"
              tileColor: "#f59a25"
            }
            ListElement {
              term: "Chill"
              tileColor: "#768d9b"
            }
            ListElement {
              term: "Party"
              tileColor: "#4a927e"
            }
            ListElement {
              term: "Workout"
              tileColor: "#ff6537"
            }
          }

          Rectangle {
            color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            width: parent.width / 2
            height: dp(30)
          }

          SearchTermTile {
            width: parent.width / 2
            height: dp(100)

            margins: root.width * 0.05

            onSelected: {
              root.searchRequested(term)
            }
          }
        }
      }
    }
  }
}
