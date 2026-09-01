import QtQuick
import Felgo

App {
  NavigationStack {
    AppPage {
      title: "Keychain"

      Column {
        anchors.fill: parent
        anchors.margins: dp(8)

        Row {
          AppButton {
            text: "Store in Keychain"
            onClicked: nativeUtils.setKeychainValue("identifier", valueField.text)
          }
          AppTextField {
            id: valueField
            text: "value"
          }
        }

        AppButton {
          text: "Read Keychain"
          onClicked: NativeUtils.displayAlertDialog("Keychain Value", NativeUtils.getKeychainValue("identifier"))
        }

        AppButton {
          text: "Delete from Keychain"
          onClicked: nativeUtils.clearKeychainValue("identifier")
        }
      }
    }
  }
}
