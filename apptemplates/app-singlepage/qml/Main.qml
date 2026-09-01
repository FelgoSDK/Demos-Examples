import Felgo
import QtQuick

App {
  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  NavigationStack {

    AppPage {
      title: qsTr("Main Page")

      Image {
        source: "../assets/felgo-logo.png"
        anchors.centerIn: parent
      }
    }

  }
}
