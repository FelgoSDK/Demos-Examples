import QtQuick 2.0
import Felgo 3.0


App {
  licenseKey: ""
  readonly property string oneSignalAppId: "a23e646c-0d6f-4611-836e-5bf14ee96e98"
  readonly property string oneSignalGoogleProjectNumber: "522591647137"

  NavigationStack {
    ListPage {
      title: "Local Notifications"

      model: ListModel {
        id: listModel
        ListElement { section: "Notifications"; name: "Enable notifications"; clickable: true }
        ListElement { section: "Notifications"; name: "Disable notifications"; clickable: true }

        ListElement { section: "Tags"; name: "Set tag"; clickable: true }
        ListElement { section: "Tags"; name: "Remove tag"; clickable: true }
        ListElement { section: "Tags"; name: "Request tags"; clickable: true }
        ListElement { section: "Tags"; name: "Current tags: tags not yet requested"; clickable: false }
      }

      delegate: SimpleRow {
        id: row
        text: name

        property bool isSelected: index === 0 && onesignal.enabled || index === 1 && !onesignal.enabled
        enabled: clickable === undefined || clickable

        Icon {
          anchors {
            right: parent.right
            rightMargin: dp(10)
            verticalCenter: parent.verticalCenter
          }
          icon: IconType.check
          size: dp(14)
          color: row.style.textColor
          visible: isSelected
        }

        style.showDisclosure: false

        onSelected: {
          switch (index) {
          case 0: onesignal.enabled = true; break;
          case 1: onesignal.enabled = false; break;
          case 2:
            onesignal.sendTag("group", "test")
            listModel.setProperty(5, "name", "Current tags: please request tags")
            break;
          case 3:
            onesignal.deleteTag("group")
            listModel.setProperty(5, "name", "Current tags: please request tags")
            break;
          case 4:
            onesignal.requestTags()
            listModel.setProperty(5, "name", "Current tags: requesting tags ...")
            break;
          default: console.warn("Wrong index", index); break;
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      // Define OneSignal once per app in main window
      OneSignal {
        id: onesignal

        logLevel: OneSignal.LogLevelVerbose
        appId: oneSignalAppId
        googleProjectNumber: oneSignalGoogleProjectNumber

        onNotificationReceived: {
          console.debug("Received notification:", message, JSON.stringify(additionalData), isActive)
          // Possible actions:
          // - Read message from data payload and display a user dialog
          // - Navigate to a specific screen
          // - ...
        }

        onTagsReceived: {
          var tagStr = ""
          for (var tag in tags) {
            tagStr += tag + " = " + tags[tag]
          }
          if (tagStr !== "") {
            tagStr = "Current tags: " + tagStr
          } else {
            tagStr = "Current tags: no tags set"
          }
          listModel.setProperty(5, "name", tagStr)
        }

        onUserIdChanged: {
          console.debug("Got OneSignal user id:", userId)
        }
      }
    }
  }
}
