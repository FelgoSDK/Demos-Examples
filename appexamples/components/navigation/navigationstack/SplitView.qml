import Felgo 3.0
import QtQuick 2.1


App {

  NavigationStack {
    splitView: landscape
    initialPage: mainPage
  }

  property Component mainPage: ListPage {
    title: "Settings"

    model: [
      { text: "Airplane Mode", icon: IconType.plane, group: "Connection" },
      { text: "Wi-Fi", icon: IconType.wifi, group: "Connection" },
      { text: "Bluetooth", icon: IconType.arrows, group: "Connection" },
      { text: "Mobile Data", icon: IconType.signal, group: "Connection" },
      { text: "Carrier", icon: IconType.phone, group: "Connection" },
      { text: "Notications", icon: IconType.bello, group: "Privacy" },
      { text: "Control Centre", icon: IconType.cogs, group: "Privacy" },
      { text: "Do Not Disturb", icon: IconType.moono, group: "Privacy" },
      { text: "General", icon: IconType.cog, group: "System" },
      { text: "Display & Brightness", icon: IconType.tablet, group: "System" },
      { text: "Wallpaper", icon: IconType.pictureo, group: "System" },
      { text: "Sounds", icon: IconType.volumeup, group: "System" },
      { text: "Battery", icon: IconType.flash, group: "System" }
    ]

    section.property: "group"

    onItemSelected: {
      navigationStack.popAllExceptFirstAndPush(detailPage)
    }
  }

  property Component detailPage: ListPage {
    title: "General"

    model: [
      { text: "About", group: "Operating System" },
      { text: "Software Update", group: "Operating System" },
      { text: "Storage", group: "Device" },
      { text: "Auto-Lock", group: "Device" },
      { text: "Restrictions", group: "Device" },
      { text: "Date & Time", group: "Localization" },
      { text: "Keyboard", group: "Localization" },
      { text: "Language & Region", group: "Localization" },
      { text: "Reset", group: "Other" }
    ]
    section.property: "group"

    onItemSelected: navigationStack.push(updatesPage)
  }

  property Component updatesPage: Page {
    title: "Software Update"

    AppText {
      anchors.centerIn: parent
      text: "Your software is up to date."
    }
  }
}
