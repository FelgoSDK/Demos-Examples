import Felgo
import QtQuick

import "native_examples"

App {
  NavigationStack {
    AppPage {
      title: "Native API example"

      BatteryLevel {
        id: batteryLevel
      }

      AppText {
        property real level: batteryLevel.getBatteryLevel()

        anchors.centerIn: parent

        // battery level can be -1 if unavailable, for example on iOS simulator
        text: qsTr("Battery level: %1").arg(level >= 0
                                            ? (level * 100).toFixed(0) + "%"
                                            : "(unavailable)")
      }
    }
  }
}
