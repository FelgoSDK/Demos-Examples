import QtQuick 2.0
import Felgo 4.0


App {
  Navigation {
    id: navigation

    NavigationItem {
      title: "Display Options of Navigation Drawer"
      iconType: IconType.heart

      NavigationStack {
        AppPage {
          title: "Display Options of Navigation Drawer"

          Column {
            anchors.centerIn: parent
            spacing: dp(15)

            Row {
              spacing: dp(15)
              AppText {
                text: "drawerInline"
                anchors.verticalCenter: parent.verticalCenter
              }

              AppSwitch {
                checked: navigation.drawerInline
                updateChecked: false
                anchors.verticalCenter: parent.verticalCenter
                onToggled: navigation.drawerInline = !navigation.drawerInline
              }
            }

            Row {
              spacing: dp(15)
              AppText {
                text: "drawerFixed"
                anchors.verticalCenter: parent.verticalCenter
              }

              AppSwitch {
                checked: navigation.drawerFixed
                updateChecked: false
                anchors.verticalCenter: parent.verticalCenter
                onToggled: navigation.drawerFixed = !navigation.drawerFixed
              }
            }

            Row {
              spacing: dp(15)
              AppText {
                text: "drawerMinifyEnabled"
                anchors.verticalCenter: parent.verticalCenter
              }

              AppSwitch {
                checked: navigation.drawerMinifyEnabled
                updateChecked: false
                anchors.verticalCenter: parent.verticalCenter
                onToggled: navigation.drawerMinifyEnabled = !navigation.drawerMinifyEnabled
              }
            }
          }
        }
      }
    }

    NavigationItem {
      title: "Another page"
      iconType: IconType.star

      NavigationStack {
        AppPage {
          title: "Another page"
        }
      }
    }
  }
}
