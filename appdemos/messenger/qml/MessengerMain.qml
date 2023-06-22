import Felgo 4.0


App {
  id: app

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  onInitTheme: {
    Theme.colors.tintColor = "#075E54"
    Theme.navigationBar.titleAlignBottom = false
    Theme.navigationBar.titleLeftMargin = 0

    // configure resize mode for soft keyboard handling
    if(system.platform === System.Android) {
      nativeUtils.softInputMode = NativeUtils.SoftInputModeAdjustResize
    }
    else if(system.platform === System.IOS) {
      nativeUtils.softInputMode = NativeUtils.SoftInputModeAdjustPan
    }
  }

  MessengerMainPage { }
}
