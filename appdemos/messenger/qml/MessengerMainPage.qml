import Felgo 3.0
import "pages"

Navigation {
  id: navigation
  navigationMode: navigationModeTabs

  anchors.topMargin: system.platform === System.IOS && keyboardVisible ? keyboardHeight : 0
  anchors.bottomMargin: system.platform === System.Android && keyboardVisible ? keyboardHeight : 0

  NavigationItem {
    title: qsTr("Chats")
    icon: IconType.comments

    NavigationStack {
      // fix navigation bar to not change when iOS keyboard shows
      navigationBar.height: dp(Theme.navigationBar.height) + nativeUtils.safeAreaInsets.top

      onDepthChanged: (navigation.navigationMode = (depth>1) ? navigationModeNone : navigationModeTabs)
      MessageListPage {
      }
    }
  }

  NavigationItem {
    id: groupsItem
    title: qsTr("Groups")
    icon: IconType.group

    NavigationStack {
      ListPage {
        title: groupsItem.title
        emptyText.text: qsTr("No groups joined.")
      }
    }
  }

  NavigationItem {
    id: contactsItem
    title: qsTr("Contacts")
    icon: IconType.list

    NavigationStack {
      ListPage {
        title: contactsItem.title
        emptyText.text: qsTr("No contacts.")
      }
    }
  }

  NavigationItem {
    id: settingsItem
    title: qsTr("Settings")
    icon: IconType.cog

    NavigationStack {
      ListPage {
        title: settingsItem.title
        emptyText.text: qsTr("No settings.")
      }
    }
  }
}
