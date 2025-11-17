import Felgo
import QtQuick

App {
  NavigationStack {

    AppPage {
      title: qsTr("ESP32 Read & Write")
      Rectangle {
        width: dp(20)
        height: width
        radius: width/2
        anchors.margins: dp(8)
        anchors.top: parent.top
        anchors.right: parent.right
        color: myBleDevice.connected ? 'green' : 'red'
      }
      Column {
        anchors.centerIn: parent
        spacing: dp(15)

        AppText {
          anchors.horizontalCenter: parent.horizontalCenter
          text: stringCharacteristic.value
          fontSize: dp(15)
        }

        AppTextField {
          anchors.horizontalCenter: parent.horizontalCenter
          id: textField
          text: 'Hello from Felgo!'
          width: dp(200)
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: 'Write'
          enabled: stringCharacteristic.valid && myBleDevice.connected
          onClicked: {
            textField.focus = false
            stringCharacteristic.formatWrite(textField.text)
            stringCharacteristic.read()
          }
        }
      }
    }
  }

  BluetoothLeManager {
    discoveryRunning: true

    BluetoothLeDevice {
      id: myBleDevice

      BluetoothLeService {
        uuid: '{4fafc201-1fb5-459e-8fcc-c5c9c331914b}' // Custom read/write Service

        BluetoothLeCharacteristic {
          id: stringCharacteristic
          uuid: '{beb5483e-36e1-4688-b7f5-ea07361b26a8}' // Value
          dataFormat: 0x19 //for uint32

          function formatWrite(text) {
            let data = new Uint8Array(text.length)
            for (var i = 0; i < text.length; i++) {
              data[i] = text.charCodeAt(i)
            }
            write(data.buffer)
          }

          onValidChanged: {
            // Read initial value once characteristic is valid
            if (valid) {
              read()
            }
          }
        }
      }

      onConnectedChanged: {
        // Reconnect logic
        if (!connected) {
          console.log('Trying to reconnect')
          connect()
        }
      }
    }

    onDeviceDiscovered: {
      // Match device with service UUID
      if (device.services.indexOf('{4fafc201-1fb5-459e-8fcc-c5c9c331914b}') > -1) {
        myBleDevice.setDevice(device, true)
        discoveryRunning = false
      }
    }
  }
}
