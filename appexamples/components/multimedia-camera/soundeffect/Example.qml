import Felgo
import QtQuick
import QtMultimedia


App {
  NavigationStack {
    AppPage {
      title: "SoundEffect"

      // Currently not supported at Felgo 4
      SoundEffect {
        id: bambooSound
        source: "https://freewavesamples.com/files/Bamboo.wav"
      }

      SoundEffect {
        id: bottleSound
        source: "https://freewavesamples.com/files/Bottle.wav"
      }

      Column {
        anchors.centerIn: parent

        AppButton {
          text: "Play Bamboo effect"
          flat: false
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            bambooSound.play()
          }
        }

        AppButton {
          text: "Play Bottle effect"
          flat: false
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            bottleSound.play()
          }
        }
      }
    }
  }
}
