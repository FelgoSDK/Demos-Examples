import QtQuick
import Felgo


App {
  NavigationStack {
    AppPage {
      title: "keyboardVisible and keyboardHeight"

      AppTextField {
        placeholderText: "Edit text here"
        anchors.centerIn: parent
      }

      AppText {
        id: label
        anchors {
          bottom: parent.bottom
          bottomMargin: dp(20) + (keyboardVisible ? keyboardHeight : 0)
          horizontalCenter: parent.horizontalCenter

          Behavior on bottomMargin {
              NumberAnimation {
                duration: 250
                easing.type: Easing.InOutQuad
              }
          }
        }

        text: "Label that should be shown and not covered by keyboard"
        width: dp(250)
        horizontalAlignment: Text.AlignHCenter
      }
    }
  }
}
