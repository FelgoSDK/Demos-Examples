import Felgo 3.0
import QtQuick 2.0

App {
  id: app
  NavigationStack {
    Page {
      title: qsTr("Connection Type")

      Icon {
        id: connectionIcon
        anchors.centerIn: parent
        icon: getIconForType(nativeUtils.connectionType)

        function getIconForType(type) {
          if(type === "none") {
            return IconType.close
          }
          else if(type === "wifi") {
            return IconType.wifi
          }
          else if(type === "2g"|| type === "3g"|| type === "4g" || type === "5g" || type === "cellular") {
            return IconType.signal
          }
          else {
            return IconType.question
          }
        }
      }

      AppText {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: connectionIcon.bottom
        topPadding: dp(20)
        text: "App is online: " + app.isOnline +  " with connection: " + nativeUtils.connectionType
      }
    }
  }
}
