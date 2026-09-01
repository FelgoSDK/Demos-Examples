import Felgo
import QtQuick
import QtLocation as QL
import QtPositioning
import "../"

AppPage {
  id: root
  title: qsTr("Place Search Suggestions")



  AppMap {
    id: map
    anchors.fill: parent

    // Default location is Vienna, AT
    center: QtPositioning.coordinate(48.208417, 16.372472)
    zoomLevel: 10

    // Configure map provider
    plugin: MapPlugin {}

    QL.MapQuickItem {
      id: marker

      anchorPoint {
        x: sourceItem.width / 2
        y: sourceItem.height
      }

      sourceItem: AppIcon {
        iconType: IconType.mapmarker
        color: "red"
        size: dp(30)
      }
    }
  }

  QL.GeocodeModel {
    id: geocodeModel
    plugin: MapPlugin {
     geocoding: true
    }
    autoUpdate: true
    onLocationsChanged: {
      map.center = get(0).coordinate
      map.zoomLevel = 10
      marker.coordinate = map.center
    }
  }

  QL.PlaceSearchSuggestionModel {
    id: suggenstionModel

    plugin:  MapPlugin {
      geocoding: true
     }

    onStatusChanged: {
      if (status == QL.PlaceSearchSuggestionModel.Ready) {
        suggestionsList.show()
      }
    }
  }


  AppPaper {
    height: searchTextField.height + suggestionsList.height
    anchors {
      top: parent.top
      topMargin: dp(10)
      left: parent.left
      right: parent.right
      margins: dp(10)
    }

    AppTextField {
      id: searchTextField

      width: parent.width
      anchors.horizontalCenter: parent.horizontalCenter

      leftPadding: Theme.navigationBar.defaultBarItemPadding
      placeholderText: qsTr("Search for place")

      //Perform search when typed term is accepted
      onAccepted: {
        focus = false

        if (text != "") {
          geocodeModel.query = text
        }
      }

      //Update suggestions model when typed text changed
      onDisplayTextChanged: {
        console.log()
        if (searchTextField.displayText.length > 3 && searchTextField.focus) {
          suggenstionModel.searchTerm = searchTextField.displayText.toString()
          suggenstionModel.update()
        }
      }

      //Hide suggestions when focus is lost
      onFocusChanged: {
        if (!focus) {
          suggestionsList.hide()
        }
      }

      Component.onCompleted: {
        font.pixelSize = sp(16)
      }
    }

    SuggestionsList {
       id: suggestionsList

       rowHeight: searchTextField.height
       width: parent.width

       model: suggenstionModel

       anchors {
         top: searchTextField.bottom
         horizontalCenter: parent.horizontalCenter
       }

       onProposalSelected: {
         searchTextField.focus = false
         searchTextField.text = suggestion
         geocodeModel.query = suggestion
       }
     }

  }
}
