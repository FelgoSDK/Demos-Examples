import Felgo 4.0
import QtQuick
import QtMultimedia


App {
  NavigationStack {
    AppPage {
      id: page
      title: "Video"

      MediaPlayer {
        id: player
        source: "https://storage.googleapis.com/downloads.webmproject.org/media/video/webmproject.org/big_buck_bunny_trailer_480p_logo.webm"
        videoOutput: videoOutputElement
      }

      Column {
        spacing: dp(20)
        anchors.centerIn: parent

        VideoOutput {
          id: videoOutputElement
          width: page.width
          fillMode: VideoOutput.PreserveAspectFit
        }

        Row {
          anchors.horizontalCenter: parent.horizontalCenter

          AppButton {
            text: "Play"
            flat: false
            onClicked: player.play()
          }

          AppButton {
            text: "Pause"
            flat: false
            onClicked: player.pause()
          }

          AppButton {
            text: "Stop"
            flat: false
            onClicked: player.stop()
          }
        }
      }
    }
  }
}
