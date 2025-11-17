import Felgo
import QtQuick


App {

  // TODO: You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  FirebaseDatabase {
    id: firebaseDb

    // We store the read values in those properties to display them in our text items
    property string testValue: ""
    property string realtimeTestValue: ""

    // Define which values should be read in realtime
    realtimeValueKeys: ["public/testValue"]
    // Update our local realtimeTestValue property if database value changed
    onRealtimeValueChanged: {
      if (success && key === "testValue") {
        realtimeTestValue = value
      }
    }

    // Update our local testValue property if read from database was successful
    onReadCompleted: {
      if (success) {
        console.debug("Read value " +  value + " for key " + key)
        testValue = value
      } else {
        console.debug("Error: "  + value)
      }
    }

    // Add some debug output to check if write was successful
    onWriteCompleted: {
      if (success) {
        console.debug("Successfully wrote to DB")
      } else {
        console.debug("Write failed with error: " + message)
      }
    }
  }

  NavigationStack {
    AppPage {
      title: "FirebaseDatabase"
      Column {
        anchors.fill: parent
        spacing: dp(15)

        // Button to update public/testValue with test-[currenttimestamp]
        AppButton {
          text: "Update Value"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            firebaseDb.setValue("public/testValue", "test-" + Date.now())
          }
        }

        // Button to read the public/testValue manually
        AppButton {
          text: "Get Value"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            firebaseDb.getValue("public/testValue")
          }
        }

        // Display the testValue property with a simple property binding
        AppText {
          width: parent.width
          horizontalAlignment: AppText.AlignHCenter
          text: "Manual TestValue: " + firebaseDb.testValue
        }

        // Display the realtimeTestValue property with a simple property binding
        AppText {
          width: parent.width
          horizontalAlignment: AppText.AlignHCenter
          text: "Realtime TestValue: " + firebaseDb.realtimeTestValue
        }
      }
    }
  }
}
