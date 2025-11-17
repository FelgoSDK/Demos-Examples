import Felgo
import QtQuick
import QtQuick.Controls as QC2


App {
  NavigationStack {
    AppPage {
      id: page
      title: "SpinBox"

      QC2.SpinBox {
        value: 50
        anchors.centerIn: parent

        // We constrain value in range [0,100)
        validator: IntValidator {
          bottom: 0
          top:  100
        }
      }
    }
  }
}
