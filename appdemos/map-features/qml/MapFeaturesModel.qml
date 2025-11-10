import QtQuick


ListModel {
  ListElement {
    pageUrl: "pages/BasicMapPage.qml"
    pageName: qsTr("Basic map")
  }
  ListElement {
   pageUrl: "pages/MapPluginConfigurationPage.qml"
   pageName: qsTr("Map plugin configuration")
  }
  ListElement {
    pageUrl: "pages/MapAppearancePresenterPage.qml"
    pageName: qsTr("Map appearance customization")
  }
  ListElement {
    pageUrl: "pages/UserPositionMapPage.qml"
    pageName: qsTr("Showing user position")
  }
  ListElement {
    pageUrl: "pages/GeocodingMapPage.qml"
    pageName: qsTr("Geocoding")
  }
  ListElement {
    pageUrl: "pages/ReverseGeocodingMapPage.qml"
    pageName: qsTr("Reverse geocoding")
  }
  ListElement {
    pageUrl: "pages/RoutingMapPage.qml"
    pageName: qsTr("Routing")
  }
  ListElement {
    pageUrl: "pages/PlaceSearchSuggestionsPage.qml"
    pageName: qsTr("Place Search Suggestions")
  }
}
