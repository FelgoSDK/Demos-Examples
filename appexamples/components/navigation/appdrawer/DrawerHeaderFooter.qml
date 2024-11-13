import QtQuick 2.0
import Felgo 4.0


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
      iconType: IconType.book
      NavigationStack {
        AppPage {
          title: "Book"
          backgroundColor: "salmon"
        }
      }
    }

    NavigationItem {
      title: "Image"
      iconType: IconType.image
      NavigationStack {
        AppPage {
          title: "Image"
          backgroundColor: "goldenrod"
        }
      }
    }

    NavigationItem {
      title: "Road"
      iconType: IconType.road
      NavigationStack {
        AppPage {
          title: "Road"
          backgroundColor: "moccasin"
        }
      }
    }

    NavigationItem {
      title: "Suitcase"
      iconType: IconType.suitcase
      NavigationStack {
        AppPage {
          title: "Suitcase"
          backgroundColor: "olivedrab"
        }
      }
    }
  }
}
