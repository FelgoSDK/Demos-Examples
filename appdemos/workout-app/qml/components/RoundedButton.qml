import Felgo 4.0
import QtQuick 2.0

AppButton {
  verticalMargin: 0
  horizontalMargin: 0

  minimumWidth: pressed ? dp(70) : dp(80)
  minimumHeight: minimumWidth

  radius: width/2

  flat: false
  rippleEffect: false

  Behavior on minimumWidth {
    NumberAnimation { duration: 100 }
  }

  Behavior on anchors.horizontalCenterOffset {
    NumberAnimation { duration: 200 }
  }
}
