import Felgo
import QtQuick

QtObject {
  id: appModel

  property alias connected: bleHeartMonitorDevice.connected
  property alias bleDevice: bleHeartMonitorDevice

  property BluetoothLeManager bleManager : BluetoothLeManager {
    discoveryTimeout: 30000
    discoveryRunning: false

    BluetoothLeDevice {
      id: bleHeartMonitorDevice

      BluetoothLeService {
        uuid: 0x180D

        BluetoothLeCharacteristic {
          uuid: 0x2A37
          dataFormat: 0x06

          onValueRawChanged: {
            let rawData = new Uint8Array(valueRaw)

            // Skip if not the expected size
            if(rawData.length < 4) {
              return;
            }

            console.debug("Raw data " + toHexString(rawData))

            heartRate.bpm = rawData[1]
          }

          function toHexString(byteArray) {
            return Array.from(byteArray, function(dataByte) {
              return ('0' + (dataByte & 0xFF).toString(16)).slice(-2);
            }).join('')
          }
        }
      }
    }

    onDeviceDiscovered: device => {
      // Match device with service UUID
      if (device.services.indexOf('{0000180d-0000-1000-8000-00805f9b34fb}') > -1) {
        //bleHeartMonitorDevice.setDevice(device, true)
        //discoveryRunning = false
        console.debug("Device ", JSON.stringify(device))
      }
    }
  }

  property JsonListModel devicesListModel: JsonListModel {
    source: bleManager.discoveredDevices
  }

  property SortFilterProxyModel filteredDevices: SortFilterProxyModel {
    sourceModel: devicesListModel

    filters: [
      ExpressionFilter {
       expression: !!model.services && (model.services.indexOf('{0000180d-0000-1000-8000-00805f9b34fb}') > -1)
      }
    ]
  }

  function connectToDevice(bleDevice) {
    bleHeartMonitorDevice.setDevice(bleDevice, true)
    bleManager.discoveryRunning = false
  }

}
