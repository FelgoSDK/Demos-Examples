import Felgo
import QtQuick


App {

  NavigationStack {
    splitView: landscape
    initialPage: mainPage
  }

  property Component mainPage: ListPage {
    title: "Settings"

    model: [
      { text: "Airplane Mode", iconType: IconType.plane, group: "Connection" },
      { text: "Wi-Fi", iconType: IconType.wifi, group: "Connection" },
      { text: "Bluetooth", iconType: IconType.arrows, group: "Connection" },
      { text: "Mobile Data", iconType: IconType.signal, group: "Connection" },
      { text: "Carrier", iconType: IconType.phone, group: "Connection" },
      { text: "Notications", iconType: IconType.bello, group: "Privacy" },
      { text: "Control Centre", iconType: IconType.cogs, group: "Privacy" },
      { text: "Do Not Disturb", iconType: IconType.moono, group: "Privacy" },
      { text: "General", iconType: IconType.cog, group: "System" },
      { text: "Display & Brightness", iconType: IconType.tablet, group: "System" },
      { text: "Wallpaper", iconType: IconType.pictureo, group: "System" },
      { text: "Sounds", iconType: IconType.volumeup, group: "System" },
      { text: "Battery", iconType: IconType.flash, group: "System" }
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

  property Component updatesPage: AppPage {
    title: "Software Update"

    AppText {
      anchors.centerIn: parent
      text: "Your software is up to date."
    }
  }
}
