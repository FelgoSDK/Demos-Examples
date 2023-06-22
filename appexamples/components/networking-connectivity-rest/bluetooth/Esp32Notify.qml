import Felgo 4.0
import QtQuick 2.0

App {
  NavigationStack {
    
    AppPage {
      title: qsTr("ESP32 Notify")
      
      AppText {
        anchors.centerIn: parent
        text: notifyCharacteristic.value
        fontSize: dp(15)
      }
    }
  }
  
  BluetoothLeManager {
    discoveryRunning: true
    
    BluetoothLeDevice{
      id: myBleDevice
      
      BluetoothLeService {
        uuid: '{4fafc201-1fb5-459e-8fcc-c5c9c331914b}' // Custom notify Service
        
        BluetoothLeCharacteristic {
          id: notifyCharacteristic
          uuid: '{beb5483e-36e1-4688-b7f5-ea07361b26a8}' // Value
          dataFormat: 8 // For uint32
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
      // To keep it simple, set your device reported name here
      if (device.name == 'ESP32') {
        myBleDevice.setDevice(device, true)
        discoveryRunning = false
      }
    }
  }
}