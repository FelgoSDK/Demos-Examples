import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtMultimedia 5.5
import "../common"
import "../controls"
import "../qmlvideofx/qml"


Page {
  id: page

  // for windows platform check
  property bool isWindows: system.isPlatform(4)
                           || system.isPlatform(9)
                           || system.isPlatform(10) // windows, winPhone or winRT

  rightBarItem: TextButtonBarItem {
    text: "Hide effects"

    visible: fxControls.visible

    onClicked: {
      if(fxControls.visible) {
        if (appsVideo.started) {
          appsVideo.pause()
          appsVideo.pausedByUser = true
        }
        fxControls.hide()
      }
    }
  }

  Item {
    id: flickArea
    anchors.fill: parent

    // flickable
    AppFlickable {
      id: pageFlickable

      // show/hide embedded video during scrolling to opimize scroll performance
      property real yBeginning: 0
      property real yDelta: pageFlickable.contentY - pageFlickable.yBeginning
      property real videoContentY: 0

      anchors.fill: parent
      contentHeight: content.height + dp(Theme.navigationBar.defaultBarItemPadding) * 2

      onHeightChanged: {
        videoContentY = appsVideo.parent.mapToItem(pageFlickable.contentItem, 0 , 0).y
      }

      onContentHeightChanged: {
        videoContentY = appsVideo.parent.mapToItem(pageFlickable.contentItem, 0 , 0).y
      }

      Component.onCompleted: {
        pageFlickable.yBeginning = pageFlickable.contentY
      }

      // add background to flickable to also have background within shader effect
      Rectangle {
        anchors.fill: parent
        color: page.backgroundColor
      }

      // remove focus from controls if clicked outside
      MouseArea {
        anchors.fill: parent
        onClicked: {
          pageFlickable.forceActiveFocus()
        }
      }

      // content
      Column  {
        id: content
        width: parent.width

        Section {
          title: "Custom Shaders Effects"
          spacing: dp(15)

          AppButton {
            text: fxControls.visible ? "Hide Shader Example" : "Open Shader Example"
            anchors.horizontalCenter: parent.horizontalCenter
            flat: false
            onClicked: {
              if (!fxControls.visible) {
                appsVideo.play()
                fxControls.show()
              }
              else {
                if (appsVideo.started) {
                  appsVideo.pause()
                  appsVideo.pausedByUser = true
                }
                fxControls.hide()
              }
            }
          }

          // embedded apps video
          Rectangle {
            color: "black"
            width: parent.width
            height: width / 1280 * 720

            Column {
              anchors.centerIn: parent
              width: parent.width
              spacing: dp(10)

              AppImage {
                source: "../../assets/playicon.png"
                width: dp(75)
                height: width / sourceSize.width * sourceSize.height
                anchors.horizontalCenter: parent.horizontalCenter
              }
              AppText {
                width: parent.width * 0.75
                text: "Tap to play video for live video shader effects"
                horizontalAlignment: AppText.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: AppText.WordWrap
                font.pixelSize: sp(16)
                color: "white"
              }
            }

            Video {
              id: appsVideo

              property bool started: false
              property bool pausedByUser: false

              anchors.fill: parent
              visible: (pageFlickable.yDelta + pageFlickable.height >= pageFlickable.videoContentY) && (pageFlickable.yDelta <= pageFlickable.videoContentY + height)

              source: "https://raw.githubusercontent.com/FelgoSDK/Demos-Examples/qt5/preview-assets/appdemos/component-showcase/data/multimedia/Felgo_mobile." + (isWindows ? "wmv" : "mp4")
              autoLoad: true

              onPlaying: {
                pausedByUser = false
                started = true
              }
              onStopped: {
                pausedByUser = false
                started = false
              }

              // hide and stop pause if not within visible view to improve performance
              onVisibleChanged: {
                if (!visible && started) {
                  pause()
                } else if (visible && started && !pausedByUser) {
                  play()
                }
              }

              // play / pause video on click
              MouseArea {
                anchors.fill: parent
                onClicked: {
                  if (!appsVideo.started) {
                    appsVideo.play()
                    fxControls.show()
                  } else {
                    if (appsVideo.pausedByUser) {
                      appsVideo.play()
                    } else {
                      appsVideo.pause()
                      appsVideo.pausedByUser = true
                    }
                  }
                }
              }
            }
          }


        } // custom shaders effect ssection


        Section {
          title: "Graphical effects"

          AppImage {
            id: displacementImage

            anchors.horizontalCenter: parent.horizontalCenter
            height: dp(150)
            width: height / sourceSize.height * sourceSize.width

            source: "../../assets/devices.png"
            layer.enabled: true
            layer.effect: Displace {
              id: displaceEffect

              displacement: 0.2
              displacementSource: Rectangle {
                width: displacementImage.width
                height: displacementImage.height
                color: Qt.rgba(0.5,0.5,0,1)

                AppImage {
                  id: displaceLogo
                  anchors.fill: parent
                  fillMode: AppImage.PreserveAspectFit
                  source: "../../assets/felgo-logo.png"
                }

                PropertyAnimation {
                  target: displaceEffect
                  property: "displacement"
                  duration: 1500
                  easing.type: Easing.OutBounce

                  to: 0.3
                  running: true

                  onStopped: {
                    to *= -1
                    start()
                  }
                }
              }
            } // Displace effect
          } // Displacement Image
        } // graphical effects section


        Section {
          title: "Blend Effect"
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)
          Row {
            spacing: parent.spacing
            anchors.horizontalCenter: parent.horizontalCenter
            height: blendComboBox.height

            AppText {
              text: "Blend Mode: "
              anchors.verticalCenter: parent.verticalCenter
            }

            CustomComboBox {
              id: blendComboBox
              implicitWidth: dp(110) + 30
              model: ["Normal", "Addition", "Subtract", "Multiply", "Divide", "Exclusion", "DarkerColor", "LighterColor"]
              anchors.verticalCenter: parent.verticalCenter
            }
          }

          AppImage {
            id: blendImage
            height: dp(150)
            width: height / sourceSize.height * sourceSize.width
            source: "../../assets/devices.png"
            anchors.horizontalCenter: parent.horizontalCenter
            layer.enabled: true
            layer.effect: Blend {
              mode: blendComboBox.currentText
              foregroundSource: AppImage {
                width: blendImage.width
                height: blendImage.height
                fillMode: AppImage.PreserveAspectFit
                source: "../../assets/felgo-logo.png"
              }
            } // Blend Effect
          } // Blend Image
        } // Blend effect section


        Section {
          title: "Color Adjustment"
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)

          Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: parent.spacing

            AppText {
              text: "Apply:"
              anchors.verticalCenter: parent.verticalCenter
            }

            CustomComboBox {
              id: colorComboBox
              implicitWidth: dp(160) + 30
              anchors.verticalCenter: parent.verticalCenter

              model: ["BrightnessContrast", "ColorOverlay", "Colorize", "HueSaturation"]

              onCurrentIndexChanged: {
                // apply new effect
                switch (currentIndex) {
                case 0:
                  colorEffectImage.layer.effect = brightnessContrastEffect
                  break
                case 1:
                  colorEffectImage.layer.effect = colorOverlayEffect
                  break
                case 2:
                  colorEffectImage.layer.effect = colorizeEffect
                  break
                case 3:
                  colorEffectImage.layer.effect = hueSaturationEffect
                  break
                }
              }
            }
          }

          AppImage {
            id: colorEffectImage

            anchors.horizontalCenter: parent.horizontalCenter
            height: dp(150)
            width: height / sourceSize.height * sourceSize.width

            source: "../../assets/devices.png"
            layer.enabled: true
            layer.effect: brightnessContrastEffect

            Component {
              id: brightnessContrastEffect
              BrightnessContrast {
                brightness: -0.5
                contrast: 0.5
              }
            }
            Component {
              id: colorOverlayEffect
              ColorOverlay {
                color: Qt.rgba(0,0,1,0.25)
              }
            }
            Component {
              id: colorizeEffect
              Colorize {
                hue: 0.7
                saturation: 0.5
              }
            }
            Component {
              id: hueSaturationEffect
              HueSaturation {
                hue: 0.3
                saturation: 0.5
              }
            }
          }
        } // Color adjustment section

        Section {
          title: "Improved Style"
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)

          Row {
            spacing: parent.spacing
            anchors.horizontalCenter: parent.horizontalCenter

            AppText {
              text: "Add: "
              anchors.verticalCenter: parent.verticalCenter
            }

            CustomComboBox {
              id: styleComboBox
              implicitWidth: dp(120) + 30
              anchors.verticalCenter: parent.verticalCenter

              model: ["DropShadow", "FastBlur", "RadialBlur", "Glow"]

              onCurrentIndexChanged: {
                // apply new effect
                switch (currentIndex) {
                case 0:
                  styleEffectImage.layer.effect = dropShadowEffect
                  break
                case 1:
                  styleEffectImage.layer.effect = fastBlurEffect
                  break
                case 2:
                  styleEffectImage.layer.effect = radialBlurEffect
                  break
                case 3:
                  styleEffectImage.layer.effect = glowEffect
                  break
                }
              }
            }
          }

          AppImage {
            id: styleEffectImage

            height: dp(150)
            width: height / sourceSize.height * sourceSize.width
            anchors.horizontalCenter: parent.horizontalCenter

            source: "../../assets/felgo-logo.png"
            layer.enabled: true
            layer.effect: dropShadowEffect

            Component {
              id: dropShadowEffect
              DropShadow {
                horizontalOffset: 6
                verticalOffset: 6
                radius: 12.0
                samples: 17
                color: "#80000000"
              }
            }
            Component {
              id: fastBlurEffect
              FastBlur {
                radius: dp(8)
              }
            }
            Component {
              id: radialBlurEffect
              RadialBlur {
                samples: 24
                angle: 30
              }
            }
            Component {
              id: glowEffect
              Glow {
                radius: 16
                samples: 17
                color: Qt.rgba(1,1,0,0.5)
              }
            }
          }
        } // Style Effect section

      } // column
    } // flickable

    // scroll indicator
    ScrollIndicator {
      flickable: pageFlickable
      z: 1
    }
  }

  // logo will be visible behind page when using page effect ;-)
  Column {
    anchors.centerIn: flickArea
    spacing: dp(10)
    opacity: 0.5

    AppImage {
      width: dp(50)
      source: "../../assets/felgo-logo.png"
      fillMode: AppImage.PreserveAspectFit
      anchors.horizontalCenter: parent.horizontalCenter
    }
    AppText {
      width: dp(150)
      text: "Congratulations, you found this hidden message!"
      font.pixelSize: dp(12)
      wrapMode: Text.WordWrap
      anchors.horizontalCenter: parent.horizontalCenter
    }
    AppText {
      width: dp(150)
      text: "Shaders are awesome. ;-)"
      font.pixelSize: dp(12)
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }

  // apply shader fx effect
  VideoFXEffect {
    id: fxEffect
    anchors.fill: flickArea
    divider.anchors.topMargin: fxControls.parameterPanelHeight
    sourceForShaderEffect.sourceItem: flickArea
    gripSize: fxControls.gripSize
  }

  // shader fx controls
  VideoFXControls {
    id: fxControls
    targetEffect: fxEffect
    visible: false
    onEffectLoaded: {
      if(name === "No effect") {
        fxControls.visible = false
      }
    }

    function show() {
      fxControls.visible = true
      fxEffect.divider.value = 0.5
      fxControls.loadEffect("Blur", "EffectGaussianBlur.qml")
    }

    function hide() {
      fxControls.visible = false
      fxControls.loadEffect("No effect", "EffectPassThrough.qml")
    }
  }
}
