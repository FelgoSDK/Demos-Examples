import Felgo
import QtQuick


App {
  licenseKey: ""
  readonly property string amplitudeApiKey: "47f92e5a607264e66bffa4aa3c94ce2a"

  NavigationStack {
    ListPage {

      title: "Amplitude"

      model: ListModel {
        ListElement { section: "Events"; name: "Send event" }
      }

      delegate: SimpleRow {
        text: name

        onSelected: index => {
          if (index === 0) {
            amplitude.logEvent("Send Event Clicked")
            NativeDialog.confirm("Amplitude", "event logged: Send Event Clicked", function(){ }, false)
          }
        }
      }

      section.property: "section"
      section.delegate: SimpleSection { }

      Amplitude {
        id: amplitude

        apiKey: amplitudeApiKey
      }
    }
  }
}
