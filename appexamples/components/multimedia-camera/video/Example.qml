import Felgo 4.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    AppPage {
      title: "Video"

      Column {
        anchors.centerIn: parent

        Video {
          id: video
          width: 480
          height: 270
          loops: MediaPlayer.Infinite
          anchors.horizontalCenter: parent.horizontalCenter
          source: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4"
        }

        AppButton {
          text: "Play"
          flat: false
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            video.play()
          }
        }

        AppButton {
          text: "Stop"
          flat: false
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            video.stop()
          }
        }
      }
    }
  }
}
