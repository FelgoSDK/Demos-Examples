import Felgo 3.0
import QtQuick 2.0

App {

  AppButton {
    text: "Store in Keychain"
    onClicked: nativeUtils.setKeychainValue("identifier", "value")
  }

  AppButton {
    text: "Read Keychain"
    onClicked: nativeUtils.getKeychainValue("identifier")
  }

  AppButton {
    text: "Delete from Keychain"
    onClicked: nativeUtils.clearKeychainValue("identifier")
  }
}
