import QtQuick 2.0
import Felgo 4.0

App {
  id: app

  Navigation {
    id: navigation
    navigationMode: navigationModeTabs

    NavigationItem {
      title: "Home"
      iconType: IconType.home

      NavigationStack {
        AppPage {
          title: "First Page"

          AppButton {
            text: "Start Tour"
            anchors.centerIn: parent
            onClicked: tutorialToolTip.open()
          }
        }
      }
    }

    NavigationItem {
      title: "Info"
      iconType: IconType.info

      NavigationStack {
        AppPage {
          title: "Second Page"
        }
      }
    }
  }

  AppToolTip {
    id: tutorialToolTip
    target: firstTabPlaceholder
    text: target.toolTipText

    // deactivate auto-close and use a custom handler to switch through targets
    closeOnBackgroundClick: false
    onBackgroundClicked: {
      if(tutorialToolTip.isOpen && !tutorialToolTip.isAnimating)
        tutorialToolTip.next()
    }

    function next() {
      // move to the next target if not on the last one
      if(target !== secondTabPlaceholder) {
        target = secondTabPlaceholder
      }
      // sequence done, close and reset target
      else {
        tutorialToolTip.close()
        tutorialToolTip.target = firstTabPlaceholder
      }
    }
  }

  // placeholders for AppToolTip target areas of tabs in the navigation
  property real tabWidth: width / navigation.count
  property real tabHeight: dp(Theme.navigationTabBar.height)

  Item {
    id: firstTabPlaceholder
    width: tabWidth
    height: tabHeight
    anchors.bottom: parent.bottom
    anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom

    property string toolTipText: "The first page of the app."
  }

  Item {
    id: secondTabPlaceholder
    x: tabWidth
    width: tabWidth
    height: tabHeight
    anchors.bottom: parent.bottom
    anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom

    property string toolTipText: "Go here to see the second page."
  }
}
