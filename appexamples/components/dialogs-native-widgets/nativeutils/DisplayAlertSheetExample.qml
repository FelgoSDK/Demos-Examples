import QtQuick
import Felgo


App {
  NavigationStack {
    AppPage {
      title: "Alert Sheet"

      AppButton {
        flat: false
        text: "Alert Sheet"
        anchors.centerIn: parent
        onClicked: {
          nativeUtils.displayAlertSheet("Choose wisely!", ["Option A", "Option B", "Option C"], false)
        }
      }

      Connections {
        target: nativeUtils
        function onAlertSheetFinished(index) {
          nativeUtils.displayAlertDialog("Congratulations", "You chose option " + index)
        }
      }
    }
  }
}
