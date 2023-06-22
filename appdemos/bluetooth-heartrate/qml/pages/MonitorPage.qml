import QtQuick 2.0
import Felgo 4.0

import "."
import "../components"

AppPage {
  title: qsTr("Heart Rate")

  // Use translucent navigation bar an manually handle top offset of page content
  navigationBarTranslucency: 1
  useSafeArea: false

  rightBarItem: TextButtonBarItem {
    text: "Devices"
    onClicked: {
      devicesModal.open()
    }
  }

  Heart{
    id: heart
    bpm: heartRate.beating ? heartRate.bpm : -1
    y: dp(Theme.navigationBar.height) + Theme.statusBarHeight

    MouseArea {
      anchors.fill: parent
      onClicked: devicesModal.open()
    }
  }

  BpmDisplay {
    anchors.top: heart.bottom
    anchors.topMargin: -dp(50)
    width: parent.width
    visible: true
    bpm: heartRate.bpm
    avg: heartRate.avg
    min: heartRate.min
    max: heartRate.max
    beating: heartRate.beating
  }

  DevicesModal {
    id: devicesModal
  }

  Connections {
    target: application
    onConnectedChanged: {
      if(application.connected) {
        devicesModal.close()
      }
    }
  }
}
