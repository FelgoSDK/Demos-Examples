import Felgo 3.0
import QtLocation 5.0
import QtPositioning 5.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "PlaceSearchModel"
      // Felgo Vienna office coordinate (lat, lon)
      readonly property var officeCoordinate: QtPositioning.coordinate(48.21041, 16.3891)
      property string currentSearchStatus: "Null"

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

      PlaceSearchModel {
        id: searchModel

        plugin: plugin

        searchTerm: "pizza"
        searchArea: QtPositioning.circle(page.officeCoordinate)

        onStatusChanged: {
          switch (status) {
          case PlaceSearchModel.Ready:   page.currentSearchStatus = "Ready"; break;
          case PlaceSearchModel.Loading: page.currentSearchStatus = "Loading"; break;
          case PlaceSearchModel.Error:   page.currentSearchStatus = "Error"; break;
          case PlaceSearchModel.Null:
          default: currentSearchStatus = "Null"; break;
          }
        }
      }

      Column {
        anchors.centerIn: parent
        spacing: dp(20)

        AppText {
          id: currentStatusLabel
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Current search status: " + page.currentSearchStatus
        }

        AppListView {
          height: page.height / 2
          width: page.width * 0.7
          model: searchModel
          delegate: SimpleRow {
            text: title
            badgeValue: type === PlaceSearchModel.PlaceResult ? "~" + distance.toFixed(0) + "m" : ""
            detailText: type === PlaceSearchModel.PlaceResult ? place.primaryPhone : ""
          }
        }

        AppButton {
          id: button
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Find pizza near our office!"
          onClicked: {
            searchModel.update()
          }
        }
      }
    }
  }
}
