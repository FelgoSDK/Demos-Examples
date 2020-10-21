import QtQuick 2.0
import Felgo 3.0


App {
  Navigation {
    id: navigation

    headerView: AppText {
      height: dp(50)
      anchors.centerIn: parent
      text: "Available pages:"
      color: Theme.dividerColor
    }

    footerView: AppButton {
      height: dp(50)
      anchors.centerIn: parent
      text: "Close Drawer"
      onClicked: {
        navigation.drawer.close()
      }
    }

    // Some simple pages
    NavigationItem {
      title: "Book"
      icon: IconType.book
      NavigationStack {
        Page {
          title: "Book"
          backgroundColor: "salmon"
        }
      }
    }

    NavigationItem {
      title: "Image"
      icon: IconType.image
      NavigationStack {
        Page {
          title: "Image"
          backgroundColor: "goldenrod"
        }
      }
    }

    NavigationItem {
      title: "Road"
      icon: IconType.road
      NavigationStack {
        Page {
          title: "Road"
          backgroundColor: "moccasin"
        }
      }
    }

    NavigationItem {
      title: "Suitcase"
      icon: IconType.suitcase
      NavigationStack {
        Page {
          title: "Suitcase"
          backgroundColor: "olivedrab"
        }
      }
    }
  }
}
