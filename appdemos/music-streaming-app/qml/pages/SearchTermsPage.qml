import Felgo 4.0
import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import QtQml.Models 2.1
import "../components"

AppPage {
  id: root
  navigationBarHidden: true
  useSafeArea: false

  signal searchRequested(string term)

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
        height: dp(100)

        AppText {
          text: "Search"
          anchors { horizontalCenter: parent.horizontalCenter ; bottom: parent.bottom ; bottomMargin: dp(20) }
          font.bold: true
          font.pixelSize: sp(40)
        }
      }

      Item {
        width: parent.width
        height: mockedSearchBar.height
        z: 1000

        MockedSearchBar {
          id: mockedSearchBar
          y: flickable.contentY > titleContainer.height + dp(15) ? flickable.contentY - (titleContainer.height + dp(15)) : 0
          onClicked: root.searchRequested("")
        }
      }

      AppText {
        id: browseLabel
        anchors { left: parent.left ; leftMargin: parent.width * 0.05 }

        text: qsTr("Browse all")
        font.bold: true
      }

      Grid {
        width: parent.width
        columns: 2

        Repeater {
          model: ListModel {
            ListElement { tileColor: "#f59a25"; term: "Podcast"      }
            ListElement { tileColor: "#768d9b"; term: "New Releases" }
            ListElement { tileColor: "#4a927e"; term: "Hip-Hop"      }
            ListElement { tileColor: "#ff6537"; term: "Pop"          }
            ListElement { tileColor: "#f135a3"; term: "Rock"         }
            ListElement { tileColor: "#f14735"; term: "Gaming"       }
            ListElement { tileColor: "#f59a25"; term: "Wellness"     }
            ListElement { tileColor: "#768d9b"; term: "Chill"        }
            ListElement { tileColor: "#4a927e"; term: "Party"        }
            ListElement { tileColor: "#ff6537"; term: "Workout"      }
          }

          Rectangle {
            color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            width: parent.width / 2
            height: dp(30)
          }

          SearchTermTile {
            width: parent.width / 2
            height: dp(100)
            margins: dp(32)
            onSelected: root.searchRequested(term)
          }
        }
      }
    }
  }
}
