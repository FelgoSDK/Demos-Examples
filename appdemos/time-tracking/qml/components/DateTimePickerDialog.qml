import Felgo
import QtQuick

Dialog {
  id: dialog
  anchors.fill: parent
  autoSize: true

  title: "Select start time"
  titleDividerVisible: Theme.isIos

  onCanceled: close()
  onAccepted: close()

  property alias datePicker: picker

  DatePicker {
    id: picker
    width: parent.width
    //dateFormat: "MMM d, yyyy"
    dateFormat: "ddd d. MMM"
  }
}
