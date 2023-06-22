import Felgo 4.0
import QtQuick 2.0
import QtSensors 5.0


App {
  readonly property string notAvailableString: "Not available"

  NavigationStack {

    Accelerometer {
      id: accelerometer
      active: true
    }

    AppPage {
      title: "Accelerometer"

      Column {

        anchors.centerIn: parent

        AppText {
          text: "Accelerometer values:"
          font.bold: true
          anchors.horizontalCenter: parent.horizontalCenter
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "X: " + (accelerometer.reading ? accelerometer.reading.x.toFixed(4) : notAvailableString)
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Y: " + (accelerometer.reading ? accelerometer.reading.y.toFixed(4) : notAvailableString)
        }

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Z: " + (accelerometer.reading ? accelerometer.reading.z.toFixed(4) : notAvailableString)
        }
      }
    }
  }
}
