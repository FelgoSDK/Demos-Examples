import Felgo 3.0
import QtQuick 2.0


App {
  licenseKey: ""
  readonly property string googleAnalyticsPropertyId: "UA-32264673-5"

  NavigationStack {
    ListPage {
      title: "GoogleAnalytics"

      model: ListModel {
        ListElement { section: "Pages"; name: "Send page view" }
        ListElement { section: "Events"; name: "Send event" }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          if (index === 0) {
            googleAnalytics.logScreen("GoogleAnalyticsPage")
            NativeDialog.confirm("Google Analytics", "screen logged:
    GoogleAnalyticsPage", function() {}, false)
          }
          else if (index === 1) {
            googleAnalytics.logEvent("Buttons", "Send Event Clicked")
            NativeDialog.confirm("Google Analytics", "event logged:
    Buttons
    Send Event Clicked", function(){}, false)
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      GoogleAnalytics {
        id: googleAnalytics

        propertyId: Constants.googleAnalyticsPropertyId
      }
    }
  }
}
