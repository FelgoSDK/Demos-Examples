import Felgo
import QtQuick
import QtQuick.Layouts
import "../common"
import "../details"

FlickablePage {
  title: "Settings"
  rightBarItem: ActivityIndicatorBarItem { opacity: dataModel.loading ? 1 : 0 }
  flickable.contentWidth: width
  flickable.contentHeight: Math.max(flickable.height, contentCol.height + dp(20))
  backgroundColor: Theme.colors.secondaryBackgroundColor

  Column {
    id: contentCol
    width: parent.width

    SimpleSection {
      title: qsTr("Notifications")
    }

    AppListItem {
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          id: notificationIcon
          iconType: IconType.clocko
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      firstInSection: true
      lastInSection: true
      text: qsTr("Session reminders")
      showDisclosure: false
      rightItem: AppSwitch {
        anchors.verticalCenter: parent.verticalCenter
        checked: dataModel.notificationsEnabled
        updateChecked: false
        onToggled: {
          logic.setNotificationsEnabled(!checked)
        }
      }
      detailText: "Sends a push notification 10 minutes before a favorited session is starting."
    }

    SimpleSection {
      title: qsTr("App theme")
    }

    AppListItem {
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          id: darkThemeIcon
          iconType: appDetails.darkMode ? IconType.moono : IconType.suno
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      firstInSection: true
      text: qsTr("Dark mode")
      showDisclosure: false
      rightItem: AppSwitch {
        id: darkThemeSwitch
        anchors.verticalCenter: parent.verticalCenter
        checked: appDetails.darkMode
        onToggled: {
          appDetails.darkMode = checked
        }
      }
    }

    AppListItem {
      property string target: Theme.platform !== "ios" ? "iOS" : "Android"
      property string currentTheme: Theme.platform === "ios" ? "iOS" : "Android"

      function themeDisplayString(theme) {
        return Qt.platform.os === "ios" && theme === "Android" ? "Material" : theme
      }

      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          id: themeIcon
          iconType: Theme.platform === "ios" ? IconType.apple : IconType.android
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      text: qsTr("Theme: ") + themeDisplayString(currentTheme)
      showDisclosure: false
      detailText: qsTr("Click to change to ") + themeDisplayString(target)
      onSelected: {
        Theme.platform = target.toLowerCase()
      }
    }

    AppListItem {
      insetStyle: Theme.isIos
      leftItem: Item {
        width: dp(26)
        height: parent.height
        AppIcon {
          id: resetIcon
          iconType: IconType.backward
          size: dp(17)
          anchors.centerIn: parent
        }
      }
      lastInSection: true
      text: qsTr("Reset theme")
      showDisclosure: false
      onSelected: {
        Theme.reset()
        appDetails.darkMode = true
        darkThemeSwitch.checked = true
      }
    }
  }
} // Page
