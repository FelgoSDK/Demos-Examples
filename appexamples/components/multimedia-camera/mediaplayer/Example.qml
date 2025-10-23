import Felgo
import QtQuick
import QtMultimedia


App {
  NavigationStack {
    AppPage {
      id: page
      title: "MediaPlayer"

      MediaPlayer {
        id: mediaplayer

        // Set local file as source
        // source: Qt.resolvedUrl("assets/example.mp4")

        // Set URL as source
        source: "https://raw.githubusercontent.com/FelgoSDK/Demos-Examples/master/preview-assets/appexamples/components/multimedia-camera/mediaplayer/assets/example.mp4"
        videoOutput: output
        audioOutput: AudioOutput{}
      }

      VideoOutput {
        id: output
        anchors.fill: parent
      }

      AppButton {
        id: startfield
        text: "Click me to play video"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
          mediaplayer.stop()
          mediaplayer.play()
        }
      }
    }
  }
}
