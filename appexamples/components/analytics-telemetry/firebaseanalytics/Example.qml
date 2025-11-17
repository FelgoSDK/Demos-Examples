import Felgo
import QtQuick


App {
  licenseKey: ""

  FirebaseAnalytics {
    id: ga

    // UA property ID:
    //propertyId: "UA-32264673-5"

    // GAv4 web measurement ID for desktop:
    measurementId: "G-GB8PY1E0JT"
    userId: "USER15"

    onPluginLoaded: {
      logScreen("anyscreen")
      logEvent("anyevent", {
                 a: 14,
                 b: 15
               })
    }
  }

  NavigationStack {
    ListPage {
      title: "Firebase Analytics"

      model: ListModel {
        ListElement { section: "Events"; name: "Log event" }
        ListElement { section: "Events"; name: "Log screen" }
        ListElement { section: "General"; name: "Set user ID" }
        ListElement { section: "General"; name: "Set user property" }
        ListElement { section: "General"; name: "Reset data" }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      delegate: SimpleRow {
        text: name
        onSelected: function(index) {
          if (index === 0) {
            ga.logEvent("ButtonClicked", {})
            NativeDialog.confirm("Firebase Analytics", "event logged:\nButtonClicked", function() {}, false)
          }
          else if (index === 1) {
            ga.logScreen("FirebaseAnalyticsPage")
            NativeDialog.confirm("Firebase Analytics", "screen logged:\nFirebaseAnalyticsPage", function(){}, false)
          }
          else if(index === 2) {
            ga.userId = "USER19"
            NativeDialog.confirm("Firebase Analytics", "User ID changed:\nUSER19", function(){}, false)
          }
          else if(index === 3) {
            let propVal = Math.round(Math.random() * 1000)
            ga.setUserProperty("the_prop", propVal)
            NativeDialog.confirm("Firebase Analytics", "Set user property:\nthe_prop = "+propVal, function(){}, false)
          }
          else if(index === 4) {
            ga.resetAnalyticsData()
            NativeDialog.confirm("Firebase Analytics", "Reset data", function(){}, false)
          }
        }
      }
    }
  }
}
