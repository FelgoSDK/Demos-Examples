import Felgo 3.0
import "pages"

Navigation {
  id: navigation

  navigationMode: navigationModeTabs

  NavigationItem {
    title: qsTr("Recent")
    icon: IconType.clocko

    NavigationStack {
      MessageListPage {}
    }
  }

  NavigationItem {
    id: groupsItem
    title: qsTr("Groups")
    icon: IconType.group

    NavigationStack {
      ListPage {
        title: groupsItem.title
        emptyText.text: qsTr("No groups available.")
      }
    }
  }

  NavigationItem {
    id: peopleItem
    title: qsTr("People")
    icon: IconType.list

    NavigationStack {
      ListPage {
        title: peopleItem.title
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
