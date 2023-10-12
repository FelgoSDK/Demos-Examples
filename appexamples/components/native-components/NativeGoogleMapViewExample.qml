import Felgo 3.0
import QtQuick 2.0

import "native_controls"

App {
  NavigationStack {
    Page {
      title: "Native MapView example"

      DynamicNativeMapView {
        id: map
        anchors.fill: parent

        iosApiKey: "AIzaSyCH0xVUtMwMVwOmY5Ow2r7_Iw9_KZNsaYU"

        latitude: 48.210353
        longitude: 16.389079
      }

      AppButton {
        x: dp(12)
        y: dp(12)
        text: "Reset map"
        onClicked: {
          map.latitude = 48.210353
          map.longitude = 16.389079
          map.updateMapLocation()
        }
      }
    }
  }
}
