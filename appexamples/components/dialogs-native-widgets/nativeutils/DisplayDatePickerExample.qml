import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
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
    onDatePickerFinished: function (accepted, date) {
      if (accepted) {
        nativeUtils.displayAlertDialog("Date Picked", date)
      }
    }
  }
}
