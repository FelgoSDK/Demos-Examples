import QtQuick 2.0
import Felgo 3.0

AppModal {
  id: modal
  pushBackContent: navigationStack

  onOpened: {
    // Start search on modal opening, if not already running or connected
    if(!application.connected && !application.bleManager.discoveryRunning) {
      application.bleManager.discoveryRunning = true
    }
  }

  NavigationStack {
    navigationBar.titleAlignLeft: false

    Page {
      title: qsTr("Devices")

      leftBarItem: TextButtonBarItem {
        text: "Close"
        onClicked: {
          if(application.bleManager.discoveryRunning) {
            application.bleManager.discoveryRunning = false
          }
          modal.close()
        }
      }

      rightBarItem: TextButtonBarItem {
        id: searchButton
        visible: !application.connected
        text: application.bleManager.discoveryRunning ? qsTr("Stop") : qsTr("Search")

        onClicked: {
          application.bleManager.discoveryRunning = !application.bleManager.discoveryRunning
        }

        AppActivityIndicator {
          animating: application.bleManager.discoveryRunning
          hidesWhenStopped: true
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.left
          anchors.rightMargin: -dp(15)
          iconSize: dp(16)
        }
      }

      AppListView {
        id: devicesListView
        anchors.fill: parent
        model: application.filteredDevices
        enabled: !application.connected
        opacity: deviceCard.opacity == 0

        Behavior on opacity {
          NumberAnimation {
            duration: 150
          }
        }

        delegate: AppListItem {
          text: model.name !== "" ? model.name : qsTr("Unknown")
          detailText: qsTr("BLE Services %1").arg(model.services.length)
          showDisclosure: false
          rightItem: Icon {
            icon: "\uf294"
            anchors.verticalCenter: parent.verticalCenter
            width: dp(26)
          }

          onSelected: {
            NativeDialog.confirm(qsTr("Connect"), qsTr("Connect to %1?").arg(text), function(accepted) {
              if(accepted) {
                // Get the unmodified model data
                application.connectToDevice(application.filteredDevices.get(index))
              }
            })
          }
        }
      }

      AppCard {
        id: deviceCard
        enabled: opacity == 1
        opacity: application.connected
        width: parent.width
        margin: dp(15)
        paper.radius: dp(5)

        paper.background.color: Theme.listItem.backgroundColor

        Behavior on opacity {
          NumberAnimation {
            duration: 300
          }
        }

        content: AppText {
          width: parent.width
          leftPadding: dp(Theme.contentPadding)
          topPadding: dp(Theme.contentPadding)
          text: application.bleDevice.name !== "" ? application.bleDevice.name : qsTr("Unkown device")
        }

        actions: Row {
          AppButton {
            text: qsTr("Disconnect")
            flat: false
            horizontalMargin: dp(Theme.contentPadding)
            verticalMargin: dp(Theme.contentPadding)
            onClicked: {
              NativeDialog.confirm(qsTr("Disconnect"), qsTr("Disconnect this device?"), function(accepted) {
                if(accepted) {
                  application.bleDevice.disconnect()
                }
              })
            }
          }
        }
      }
    }
  }
}
