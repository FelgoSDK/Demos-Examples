import Felgo 3.0
import QtQuick 2.0


App {
  NavigationStack {
    Page {
      id: page
      title: "DatePicker"

      AppTextField {
        id: textField
        anchors.centerIn: parent
        width: dp(200)
        placeholderText: "Pick a date"

        // Disable manual editing of this field and fires an event when the user clicks on it
        clickEnabled: true
        readOnly: true

        onClicked: {
          // Display a native date picker on each platform. Result is returned as a slot of nativeUtils
          nativeUtils.displayDatePicker()
        }

        Connections {
          target: nativeUtils

          // Here we intercept the result.
          onDatePickerFinished: (accepted, date) => {
            if (accepted) textField.text = convertDateToString(date)
          }

          function convertDateToString(date) {
            return new Date(date).toLocaleDateString(Locale.ShortFormat)
          }
        }
      }
    }
  }
}
