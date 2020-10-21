import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    Page {
      title: "Video"

      Column {
        anchors.centerIn: parent

        Video {
          id: video
          width: 480
          height: 270
          loops: MediaPlayer.Infinite
          anchors.horizontalCenter: parent.horizontalCenter
          source: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"
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
