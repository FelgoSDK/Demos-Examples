import Felgo
import QtQuick
import QtMultimedia


App {
  NavigationStack {
    AppPage {
      id: page
      title: "Audio"

      AppText {
        text: "Click Me!"
        anchors.centerIn: parent

        // Currently not supported at Felgo 4
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
