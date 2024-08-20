import Felgo 4.0
import QtLocation 5.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      id: page
      title: "GeocodeModel"
      property string coordinatesLabel: "Unknown"

      Plugin {
        id: plugin
        name: "mapbox"
        // Configure your own map_id and access_token here
        parameters: [  PluginParameter {
            name: "mapbox.mapping.map_id"
            value: "mapbox/streets-v11"
          },
          PluginParameter {
            name: "mapbox.access_token"
            value: "pk.eyJ1IjoiZ3R2cGxheSIsImEiOiJjaWZ0Y2pkM2cwMXZqdWVsenJhcGZ3ZDl5In0.6xMVtyc0CkYNYup76iMVNQ"
          },
          PluginParameter {
            name: "mapbox.mapping.highdpi_tiles"
            value: true
          }]
      }

      GeocodeModel {
        id: geocodeModel
        plugin: plugin
        autoUpdate: false

        onLocationsChanged: {
          const location = geocodeModel.get(0)
          if (location) {
            const lat = location.coordinate.latitude.toFixed(3)
            const lon = location.coordinate.longitude.toFixed(3)
            page.coordinatesLabel = "Coordinates: (" + lat + ", " + lon + ")"
          } else {
            page.coordinatesLabel = "Unknown"
          }
        }
        onStatusChanged: {
          if (status !== GeocodeModel.Ready) {
            page.coordinatesLabel = "Unknown"
            if (status === GeocodeModel.Error) {
              console.error(errorString)
            }
          }
        }
      }

      Column {
        anchors.centerIn: parent
        spacing: dp(20)

        AppTextField {
          id: textInput
          anchors.horizontalCenter: parent.horizontalCenter
          width: page.width * 0.7
          text: "Kolonitzgasse 9 1030 Vienna, Austria"
        }

        AppText {
          id: coordsLabel
          anchors.horizontalCenter: parent.horizontalCenter
          text: page.coordinatesLabel
        }

        AppButton {
          id: button
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Get coordinates of given location"
          onClicked: {
            geocodeModel.query = textInput.text
            geocodeModel.update()
          }
        }
      }
    }
  }
}
