import Felgo 3.0
import QtQuick 2.0
import "../../components"
import "../../model"


AppModal {
  id: root

  pushBackContent: navigation
  overlayColor: "#fff"
  overlayOpacity: 0.05

  fullscreen: false

  NavigationStack {
    id: navigationStack

    navigationBar.backgroundColor: Theme.navigationTabBar.backgroundColor
    navigationBar.titleItem: AppText {
      text: navigationStack.currentTitle
      color: Theme.textColor
    }

    initialPage: AddPostPage {
      id: addPostPage
    }
  } // navigation stack

  onClosed: {
    addPostPage.reset()
  }

  onOpened: {
    addPostPage.forceTyping()
  }
}
