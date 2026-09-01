import Felgo
import QtQuick
import "../details"

AppButton {
  id: jumpToNowButton
  anchors.horizontalCenter: parent.horizontalCenter
  text: "jump to now"

  // styling
  flat: false
  radius: width * 0.12
  backgroundColor: Theme.tintColor
  backgroundColorPressed: Theme.tintLightColor
  borderWidth: 0
  textColor: appDetails.darkMode ? Theme.backgroundColor : Theme.textColor
  textColorPressed: textColor
  textSize: sp(12)
  minimumHeight: 0
  minimumWidth: 0

  property bool useYAnimation: true

  // animate opacity and y position
  Behavior on opacity {
    PropertyAnimation { duration: 250 }
  }

  Behavior on y {
    enabled: jumpToNowButton.useYAnimation
    PropertyAnimation { duration: 250 }
  }

  Behavior on anchors.bottomMargin {
    enabled: !jumpToNowButton.useYAnimation
    PropertyAnimation { duration: 250 }
  }
}
