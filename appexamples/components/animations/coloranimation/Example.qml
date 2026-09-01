import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      id: page
      title: "ColorAnimation"

      AppButton {
        anchors {
          horizontalCenter: parent.horizontalCenter
          bottom: parent.bottom
          bottomMargin: nativeUtils.safeAreaInsets.bottom
        }
        text: "Colorize"
        flat: false
        onClicked: {
          // Set random color as destination color and start animation
          colorAnimation.to = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
          colorAnimation.start()
        }
      }

      Rectangle {
        id: colorRectangle
        anchors.centerIn: parent
        width: dp(200)
        height: dp(200)
        color: "red"
      }

      ColorAnimation {
        id: colorAnimation
        target: colorRectangle
        property: "color"
        duration: 1000
      }
    }
  }
}
