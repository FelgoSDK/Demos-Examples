import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    Page {
      id: page
      title: "MediaPlayer"

      AppText {
        text: "Click me to play video"
        anchors.centerIn: parent

        MouseArea {
          id: playArea
          anchors.fill: parent
          onPressed: {
            mediaplayer.play()
          }
        }
      }

      MediaPlayer {
        id: mediaplayer

        // Set local file as source
        // source: Qt.resolvedUrl("assets/example.mp4")

        // Set URL as source
        source: "https://raw.githubusercontent.com/FelgoSDK/Demos-Examples/qt5/preview-assets/appexamples/components/multimedia-camera/mediaplayer/assets/example.mp4"
      }

      VideoOutput {
        width: 480
        height: 270
        anchors.centerIn: parent
        source: mediaplayer
        z: 2
      }
    }
  }
}
