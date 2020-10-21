import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    Page {
      id: page
      title: "Audio"

      AppText {
        text: "Click Me!"
        anchors.centerIn: parent

        Audio {
          id: playMusic
          // NOTE: File bgmusic.wav from Examples\Felgo\demos\StackTheBoxWithCommunityEditor\assets\snd
          // TODO: Use remote video and/or store it a somewhere
          source: Qt.resolvedUrl("assets/bgmusic.wav")
          onError: {
            console.error("Audio error:", error, errorString)
          }
        }

        MouseArea {
          id: playArea
          anchors.fill: parent
          onPressed: {
            playMusic.play()
          }
        }
      }
    }
  }
}
