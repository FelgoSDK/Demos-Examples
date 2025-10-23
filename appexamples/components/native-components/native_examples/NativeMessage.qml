import QtQuick
import Felgo

Item {
  // returns battery level between 0 and 1 on mobile platforms
  function showMessage(message) {
    // only instantiate relevant item on the correct platform
    if(Qt.platform.os === "android") {
      return androidMessage.createObject().showMessage(message)
    }
    else if(Qt.platform.os === "ios") {
      return iosMessage.createObject().showMessage(message)
    }
    else {
      return 0
    }
  }

  property Component androidMessage: Item {
    // imports and constants:
    property NativeClass _Toast: NativeObjectUtils.getClass("android/widget/Toast")

    property NativeObject context: NativeObjectUtils.getContext()

    function showMessage(message) {
      // Corresponding Java code: (call on UI thread)
      //      Toast.makeText(QtNative.activity(), message, Toast.LENGTH_LONG).show();

      _Toast
        .callStaticMethod("makeText",
                          [context, message,
                           _Toast.getStaticProperty("LENGTH_LONG")],
                          NativeObject.UiThread)
        .callMethod("show")
    }
  }

  property Component iosMessage: Item {
    // imports:
    property NativeClass _UIAlertController: NativeObjectUtils.getClass("UIAlertController")
    property NativeClass _UIAlertAction: NativeObjectUtils.getClass("UIAlertAction")
    property NativeClass _UIApplication: NativeObjectUtils.getClass("UIApplication")

    function showMessage(message) {
      // Corresponding Objective C code:
      // UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Alert controller" message:message preferredStyle:0];
      // [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:0 handler:nil]];
      // [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:controller animated:true completion:nil];

      var controller = _UIAlertController.callStaticMethod("alertControllerWithTitle:message:preferredStyle:",
                                                          ["Alert controller", message, 0])

      var action = _UIAlertAction.callStaticMethod("actionWithTitle:style:handler:",
                                                  ["OK", 0, null])
      controller.callMethod("addAction:", action)

      var root = _UIApplication.getStaticProperty("sharedApplication").getProperty("keyWindow").getProperty("rootViewController")
      root.callMethod("presentViewController:animated:completion:", [controller, true, null])
    }
  }
}
