import Felgo 4.0
import QtQuick
import QtMultimedia


App {
  NavigationStack {
    AppPage {
      id: page
      title: "AlphaVideo"

      Rectangle {
        anchors.fill: parent

        gradient: Gradient {
          GradientStop { position: 0.0; color: "dodgerblue" }
          GradientStop { position: 1.0; color: "firebrick" }
        }

        // Not supported at Felgo 4 currently
        AlphaVideo {
          id: video
          autoPlay: true
          anchors.fill: parent
          loops: MediaPlayer.Infinite

          // Set local file as source
          // source: Qt.resolvedUrl("assets/AlphaAnimation.mp4")

          // Set URL as source
          source: "https://raw.githubusercontent.com/FelgoSDK/Demos-Examples/master/preview-assets/appexamples/components/multimedia-camera/alphavideo/assets/AlphaAnimation.mp4"
        }

        AppText {
          anchors.centerIn: parent
          text: "Can't load video."
          visible: video.error !== MediaPlayer.NoError
        }
      }
    }
  }
}
