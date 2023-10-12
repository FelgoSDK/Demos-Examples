import Felgo 3.0
import QtQuick 2.0
import QtPositioning 5.0


App {
  NavigationStack {
    Page {
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
