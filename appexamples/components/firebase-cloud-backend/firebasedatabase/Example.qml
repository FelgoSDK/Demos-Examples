import Felgo
import QtQuick


App {
  licenseKey: ""

  readonly property string dbKey: "DevApp"

  NavigationStack {
    AppPage {
      title: "FirebaseDatabase"

      Column {
        anchors.centerIn: parent

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          fontSize: sp(20)
          text: "Message stored in DB:"
        }

        AppTextField {
          id: textInput
          anchors.horizontalCenter: parent.horizontalCenter
          font.pixelSize: sp(20)

          SequentialAnimation {
            // Animation to show that data was changed in DB (someone else changed it)
            id: blink
            ColorAnimation {
              target: textInput
              property: "backgroundColor"
              duration: 200
              from: Theme.backgroundColor
              to: "salmon"
            }
            ColorAnimation {
              target: textInput
              property: "backgroundColor"
              duration: 200
              from: "salmon"
              to: Theme.backgroundColor
            }
          }
        }

        AppButton {
          text: "Update value!"
          textSize: sp(20)
          flat: false
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            firebaseDb.setValue(dbKey, textInput.text)
          }
        }
      }

      FirebaseDatabase {
        id: firebaseDb
        // We are going to receive real-time changes from the database for given key
        realtimeValueKeys: [ dbKey ]
        persistenceEnabled: true
        config: FirebaseConfig {
          name: "FirebaseExamples-config"
          // Get these values from the firebase console
          projectId: "felgoexamples"
          databaseUrl: "https://felgoexamples.firebaseio.com"
          // Platform dependent - get these values from the google-services.json / GoogleService-info.plist
          apiKey:        Qt.platform.os === "android"
                         ? "AIzaSyCVXqBt9b7wDYWm2d0gIYR-Z-ovskPS0A0"
                         : "AIzaSyBFzY_cOQCNmwMCG7O2lWCH86tIMIisn8s"
          applicationId: Qt.platform.os === "android"
                         ? "1:176656077145:android:c7b46c9f42dfcd45cd7c48"
                         : "1:176656077145:ios:e0c5cba695028a7dcd7c48"
        }

        onFirebaseReady: {
          console.log("FirebaseReady")
          firebaseDb.getValue(dbKey)
        }

        onReadCompleted: { // Args: success, string key, variant value
          if (success) {
            console.log("Read value for key", key, "from DB:", value)
            textInput.text = value
          } else {
            console.log("Can't read", key, "from DB.")
          }
        }

        onWriteCompleted: { // Args: success, string message
          if (success) {
            console.log("Write value was successful!")
          } else {
            console.log("Value was not written to DB. ", message)
          }
        }

        onRealtimeValueChanged: { // Args: success, string key, var value
          console.error(success, key, value)
          if (success) {
            if (key === dbKey) {
              textInput.text = value
              blink.start()
            }
          }
        }
      }
    }
  }
}
