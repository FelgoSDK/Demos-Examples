import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "Date Picker"

      AppButton {
        flat: false
        anchors.centerIn: parent
        text: "Date Picker"
        onClicked: {
          nativeUtils.displayDatePicker("Pick your favorite date!")
        }
      }
    }
  }

  Connections {
    target: nativeUtils
    // Here we get notified of the date picked signal
    function onDatePickerFinished(accepted, date) {
      if (accepted) {
        nativeUtils.displayAlertDialog("Date Picked", date)
      }
    }
  }
}
