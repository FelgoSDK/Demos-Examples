import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0


App {
  NavigationStack {
    Page {
      title: "SoundEffect"

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
