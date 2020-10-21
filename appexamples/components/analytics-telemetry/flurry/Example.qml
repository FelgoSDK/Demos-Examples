import Felgo 3.0
import QtQuick 2.0


App {
  licenseKey: ""
  readonly property string flurryApiKey: "HMV9VC35FS77G6QK9TNZ"

  NavigationStack {
    ListPage {

      title: "Flurry"

      model: ListModel {
        ListElement { section: "Events"; name: "Send event" }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          if (index === 0) {
            flurry.logEvent("Buttons", "Send Event Clicked")
            NativeDialog.confirm("Flurry", "event logged:
    Buttons
    Send Event Clicked", function(){ }, false)
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      Flurry {
        id: flurry

        apiKey: Constants.flurryApiKey
      }
    }
  }
}
