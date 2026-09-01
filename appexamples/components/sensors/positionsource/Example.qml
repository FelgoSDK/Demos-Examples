import Felgo
import QtQuick
import QtPositioning


App {
  NavigationStack {
    AppPage {
      id: page
      preferredScreenOrientation: NativeUtils.ScreenOrientationPortrait
      title: "PositionSource"

      PositionSource {
        id: src
        updateInterval: 300
        active: true

        onPositionChanged: {
          var coord = src.position.coordinate
          coordinatesText.text = "Your coordinates: \n[" + coord.longitude.toFixed(4)
              + ", " + coord.latitude.toFixed(4) + "]"
        }
      }

      AppText {
        id: coordinatesText
        fontSize: 30
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
      }
    }
  }
}
