import QtQuick 2.0
import Felgo 3.0

Item {
  // returns battery level between 0 and 1 on mobile platforms
  function getBatteryLevel() {
    // only instantiate relevant item on the correct platform
    if(Qt.platform.os === "android") {
      return androidBattery.createObject().getBatteryLevel()
    }
    else if(Qt.platform.os === "ios") {
      return iosBattery.createObject().getBatteryLevel()
    }
    else {
      return 0
    }
  }

  property Component androidBattery: Item {
    // imports and constants:
    property NativeClass _Intent: NativeObjectUtils.getClass("android/content/Intent")
    property NativeClass _IntentFilter: NativeObjectUtils.getClass("android/content/IntentFilter")
    property NativeClass _BatteryManager: NativeObjectUtils.getClass("android/os/BatteryManager")

    property NativeObject context: NativeObjectUtils.getContext()

    function getBatteryLevel() {
      // Corresponding java code (from https://developer.android.com/training/monitoring-device-state/battery-monitoring#CurrentLevel):
      // IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
      // Intent batteryStatus = context.registerReceiver(null, ifilter);
      // int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
      // int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
      // return level / (float)scale;

      var filter = _IntentFilter.newInstance(_Intent.getStaticProperty("ACTION_BATTERY_CHANGED"))
      var batteryStatus = context.callMethod("registerReceiver", [null, filter])

      var level = batteryStatus.callMethod("getIntExtra", [_BatteryManager.getStaticProperty("EXTRA_LEVEL"), -1])
      var scale = batteryStatus.callMethod("getIntExtra", [_BatteryManager.getStaticProperty("EXTRA_SCALE"), -1])

      return level / scale
    }
  }

  property Component iosBattery: Item {
    // imports:
    property NativeClass _UIDevice: NativeObjectUtils.getClass("UIDevice")

    function getBatteryLevel() {
      // Corresponding Objective C code:
      // UIDevice *device = UIDevice.currentDevice;
      // device.batteryMonitoringEnabled = YES;
      // return device.batteryLevel;

      var device = _UIDevice.getStaticProperty("currentDevice")
      device.setProperty("batteryMonitoringEnabled", true)
      return device.getProperty("batteryLevel")
    }
  }
}
