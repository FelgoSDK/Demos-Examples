import Felgo 4.0
import QtQuick 2.0

App {
  NavigationStack {
    AppPage {
      title: "Date Picker"

      AppText {
        text:  datePicker.selectedDate.toUTCString()
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: datePicker.top
      }

      DatePicker {
        id: datePicker
        anchors.centerIn: parent
      }
    }
  }
}
