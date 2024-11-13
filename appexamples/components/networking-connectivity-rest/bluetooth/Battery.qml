import Felgo 4.0
import QtQuick 2.0

App {
  NavigationStack {
    AppPage {
      title: qsTr("BLE Battery")

      Rectangle {
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.8
        radius: dp(30)
        border.color: 'black'
        border.width: dp(5)

        Rectangle {
          anchors.bottom: parent.bottom
          width: parent.width
          height: parent.height * batteryCharacteristic.value / 100
          color: batteryCharacteristic.value > 80 ? 'green' : (batteryCharacteristic.value > 30 ? 'orange' : 'red')
          radius: parent.radius
        }
      }

      AppText {
        anchors.centerIn: parent
        text: batteryCharacteristic.value + '%'
        fontSize: dp(15)
      }
    }
  }

  BluetoothLeManager {
    discoveryRunning: true

    BluetoothLeDevice{
      id: myBleDevice

      BluetoothLeService {
        uuid: 0x180F // Battery Service
        BluetoothLeCharacteristic {
          id: batteryCharacteristic
          uuid: 0x2A19 // Battery Characteristic
          dataFormat: 4 // 0x04 for uint8

          onValueChanged: {
            // Value updates
            console.log('Battery Level Changed', value)
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
      if (device.services.indexOf('{0000180f-0000-1000-8000-00805f9b34fb}') > -1) {
        myBleDevice.setDevice(device, true)
        discoveryRunning = false
      }
    }
  }
}