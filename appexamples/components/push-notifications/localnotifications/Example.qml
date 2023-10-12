import QtQuick 2.0
import Felgo 3.0


App {
  licenseKey: ""

  NavigationStack {
    ListPage {
      title: "Local Notifications"
      model: ListModel {
        ListElement { section: "Notifications"; name: "Schedule notification" }
        ListElement { section: "Notifications"; name: "Cancel all notifications" }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          if (index === 0) {
            NativeDialog.confirm( "Local Notifications",
                                 "A test notification will be scheduled to arrive in 3 seconds.",
                                 function(confirmed) {
                                   if (confirmed) {
                                     notificationmanager.schedule( {
                                                                    message: "Notification Test",
                                                                    number: 1,
                                                                    timeInterval: 3
                                                                  })
                                   }
                                 } )

          } else if (index === 1) {
            notificationmanager.cancelAllNotifications()
            NativeDialog.confirm("Local Notifications", "All notifications canceled.", null, false)
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      NotificationManager {
        id: notificationmanager
        onNotificationFired: {
          NativeDialog.confirm("Local Notifications", "Notification with id " + notificationId + " fired", null, false)
        }
      }
    }
  }
}
