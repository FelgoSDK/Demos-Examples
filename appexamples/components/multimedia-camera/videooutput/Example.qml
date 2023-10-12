import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    Page {
      id: page
      title: "Video"

      MediaPlayer {
        id: player
        source: "https://storage.googleapis.com/downloads.webmproject.org/media/video/webmproject.org/big_buck_bunny_trailer_480p_logo.webm"
        autoPlay: false
      }

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        VideoOutput {
          id: videoOutput
          source: player
          width: page.width
          fillMode: VideoOutput.PreserveAspectFit
        }

        Row {
          anchors.horizontalCenter: parent.horizontalCenter

          AppButton {
            text: "Play"
            flat: false
            onClicked: {
              player.play()
            }
          }

          AppButton {
            text: "Pause"
            flat: false
            onClicked: {
              player.pause()
            }
          }

          AppButton {
            text: "Stop"
            flat: false
            onClicked: {
              player.stop()
            }
          }
        }
      }
    }
  }
}
