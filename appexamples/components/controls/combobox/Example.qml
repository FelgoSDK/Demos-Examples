import Felgo
import QtQuick.Controls as QC2


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
