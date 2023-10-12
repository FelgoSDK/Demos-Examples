import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    Page {
      id: page
      title: "AlphaVideo"

      Rectangle {
        anchors.fill: parent

        gradient: Gradient {
          GradientStop { position: 0.0; color: "dodgerblue" }
          GradientStop { position: 1.0; color: "firebrick" }
        }

        AlphaVideo {
          id: video
          autoPlay: true
          anchors.fill: parent
          loops: MediaPlayer.Infinite

          // Set local file as source
          // source: Qt.resolvedUrl("assets/AlphaAnimation.mp4")

          // Set URL as source
          source: "https://raw.githubusercontent.com/FelgoSDK/Demos-Examples/qt5/preview-assets/appexamples/components/multimedia-camera/alphavideo/assets/AlphaAnimation.mp4"
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
