import Felgo 3.0
import QtQuick 2.0
import QtSensors 5.1


App {
  NavigationStack {
    Page {
      id: page
      preferredScreenOrientation: NativeUtils.ScreenOrientationPortrait
      title: "Compass"

      Compass {
        id: compass
        active: true
        skipDuplicates: true
      }

      Column {
        anchors.centerIn: parent

        AppText {
          id: compassStatusLabel
          fontSize: 20
          anchors.horizontalCenter: parent.horizontalCenter
          text: {
            var compassReading = compass.reading;
            if (!compassReading)
              return "Compass is not available"
            if (compassReading.calibrationLevel < 1.0 / 3)
              return "Low calibration level"
            if (compassReading.calibrationLevel < 1.0 / 2)
              return "Medium calibration level"
            if (compassReading.calibrationLevel < 1.0)
              return "High calibration level"
            return "Compass is calibrated"
          }
        }

        AppText {
          id: azimuth
          fontSize: 20
          anchors.horizontalCenter: parent.horizontalCenter
          // \u00B0 is a degree symbol
          text: "Azimuth from magnetic north: <b>" + compass.reading.azimuth.toFixed(0) + "\u00B0</b>"
        }
      }
    }
  }
}
