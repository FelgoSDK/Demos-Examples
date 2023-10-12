import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "Custom Dialog"
      AppButton {
        anchors.centerIn: parent
        text: "Custom Dialog"
        onClicked: customDialog.open()
      }

      Dialog {
        id: customDialog
        title: "Do you think this is awesome?"
        positiveActionLabel: "Yes"
        negativeActionLabel: "No"
        onCanceled: title = "Think again!"
        onAccepted: close()

        Icon {
          icon: IconType.coffee
          size: dp(50)
          anchors.centerIn: parent
        }
      }
    }
  }
}
