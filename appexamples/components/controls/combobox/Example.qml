import Felgo 4.0
import QtQuick.Controls 2.0 as QC2


App {
  NavigationStack {
    AppPage {
      id: page
      title: "ComboBox"

      QC2.ComboBox {
        anchors.centerIn: parent
        width: dp(200)

        model: [ "Banana", "Apple", "Coconut" ]

        onCurrentIndexChanged: {
          console.log("Value set to " + model[currentIndex])
        }
      }
    }
  }
}
