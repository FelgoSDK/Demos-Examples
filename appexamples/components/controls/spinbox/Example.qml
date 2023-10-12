import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    Page {
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
