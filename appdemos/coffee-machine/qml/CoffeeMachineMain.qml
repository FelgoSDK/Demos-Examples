import Felgo
import QtQuick
import QtQuick.Controls as QQC2

App {
  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  readonly property int cupLineWidth: dp(12)
  readonly property int cupContentHeight: vCup.height * 0.97
  readonly property var presets: [
    {"coffee": 1.0, "milk": 0.4, "foam": 0.6, "name": "Cappuccino"},
    {"coffee": 0.8, "milk": 1.0, "foam": 1.0, "name": "Latte"},
    {"coffee": 0.5, "milk": 0.0, "foam": 0.0, "name": "Espresso"},
    {"coffee": 1.0, "milk": 0.0, "foam": 0.0, "name": "Espresso x2"},
  ]

  function loadPreset(i){
    iSliderFoam.value   = presets[i]["foam"]
    iSliderMilk.value   = presets[i]["milk"]
    iSliderCoffee.value = presets[i]["coffee"]
  }

  onInitTheme: {
    Theme.colors.tintColor = "#000"
    Theme.normalFont = secularFont
  }

  NavigationStack {

    AppPage {
      id: page
      navigationBarHidden: true
      useSafeArea: false

      // Overall background
      Rectangle {
        id: background
        anchors.fill: parent
        color: "#BE9063"
      }

      Flow {
        id: pageSections
        anchors.fill: parent
        anchors.topMargin: nativeUtils.safeAreaInsets.top
        anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
        property bool hsplit: (page.height*0.8 < page.width)

        // First big section - Coffee Mug Visualization & Coffe Type selector
        Item {
          id:     section1
          width:  pageSections.width  * (pageSections.hsplit ? 0.5 : 1.0)
          height: pageSections.height * (pageSections.hsplit ? 1.0 : 0.5)

          ////
          // Type selector
          Item {
            id: typeSelector
            clip: true
            anchors {
              top: parent.top
              left: parent.left
              right: parent.right
              topMargin: dp(40)
            }
            height: 120

            QQC2.SwipeView {
              id: swipeView
              currentIndex: 0
              anchors {
                top: parent.top
                bottom: pageControl.top
                left: iCoffeeTypePrev.right
                right: iCoffeeTypeNext.left
              }

              onCurrentIndexChanged: loadPreset(currentIndex)
              Component.onCompleted: loadPreset(0)

              // Dynamic generate selection of types
              Repeater {
                model: presets.length
                Item {
                  AppText {
                    width: parent.width
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    visible: swipeView.currentIndex === index
                    text: presets[index]["name"]
                    color: "black"
                    font {
                      pixelSize: dp(28)
                      bold: true
                    }
                  }
                }
              }
            } // END SwipeView

            PageControl {
              id: pageControl
              pages: 4
              anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
              }
              currentPage: swipeView.currentIndex
              activeTintColor: "white"
              tintColor: vCup.border.color
            }


            IconButton {
              id: iCoffeeTypePrev
              visible: swipeView.currentIndex > 0
              size: dp(45)
              iconType: IconType.caretleft
              color: pageControl.activeTintColor
              selectedColor: vCoffee.color
              anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
              }
              onClicked: swipeView.decrementCurrentIndex()
            }

            IconButton {
              id: iCoffeeTypeNext
              visible: swipeView.currentIndex < swipeView.count-1
              size: dp(45)
              anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
              }
              iconType: IconType.caretright
              color: pageControl.activeTintColor
              selectedColor: vCoffee.color
              onClicked: swipeView.incrementCurrentIndex()
            }
          }

          ////
          // Coffee mug visualisation
          Item {
            width: height
            height: Math.min(Math.min(parent.width, parent.height-typeSelector.height-typeSelector.anchors.topMargin), dp(400))
            anchors {
              horizontalCenter: parent.horizontalCenter
              top: typeSelector.bottom
              topMargin: -16
            }

            // Cup Handle
            Rectangle {
              anchors {
                top: vCup.top
                horizontalCenter: vCup.right
              }
              width: vCup.width/2
              height: vCup.height*0.4
              color: background.color
              border.color: vCup.border.color
              border.width: cupLineWidth
              radius: border.width * 1.5
            }

            // Cup ("border")
            Rectangle {
              id: vCup
              anchors.centerIn: parent
              width:  parent.width  * 0.7
              height: parent.height * 0.7

              color: vCoffee.color
              border.color: "black"
              border.width: cupLineWidth
              radius: dp(6)

              // Hides top line of the cup
              Rectangle {
                y: -1
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - (parent.border.width * 2)
                height: parent.height - parent.border.width + 1
                color: background.color
              }

              // Milk Foam
              Canvas {
                id: vFoam
                property color color: "#dbdbdb"
                y: parent.height - parent.border.width-vCoffee.height - vMilk.height-height
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-parent.border.width*2
                height: dp(iSliderFoam.position *  cupContentHeight* 1/5)

                Path {
                  id: vFoamPath
                  startX: 0; startY: vFoam.height

                  PathCurve { x: 0; y: vFoam.height/3 }
                  PathCurve { x: vFoam.width/4; y: vFoam.height*2/3 }
                  PathCurve { x: vFoam.width*2/3; y: vFoam.height/6 }
                  PathCurve { x: vFoam.width; y: vFoam.height/3 }
                  PathCurve { x: vFoam.width; y: vFoam.height }
                }
                onPaint: {
                  var ctx = getContext("2d")
                  ctx.path = vFoamPath
                  ctx.closePath()
                  ctx.fillStyle = vFoam.color
                  ctx.fill()
                }
              }

              // Milk
              Rectangle {
                id: vMilk
                y: parent.height-parent.border.width - vCoffee.height-height
                width: parent.width - parent.border.width*2
                height: iSliderMilk.position * cupContentHeight *2/5

                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
              }

              // Coffee
              Rectangle {
                id: vCoffee
                y: parent.height-parent.border.width-height
                width: parent.width-parent.border.width*2
                height: iSliderCoffee.position * cupContentHeight * 2/5
                color: "#60230a"
                anchors.horizontalCenter: parent.horizontalCenter
              }
            }

            // Cup Plate
            Rectangle {
              id: vPlate
              anchors {
                top: vCup.bottom
                topMargin: dp(5)
                horizontalCenter: vCup.horizontalCenter
              }
              width: parent.width*0.75
              height: cupLineWidth
              color: vCup.border.color
              radius: vCup.radius
            }

            // Vapour
            Row {
              id: vVapour
              readonly property int stripes: 4
              readonly property color color: "#30ffffff"
              visible: (iSliderCoffee.value + iSliderFoam.value + iSliderMilk.value) < 2.2 && iSliderCoffee.value > 0.05
              anchors {
                top: vCup.top
                bottom: vCup.bottom
                left: vCup.left
                right: vCup.right
                bottomMargin: vMilk.height + vCoffee.height + vFoam.height + anchors.leftMargin*0.2
                leftMargin: vCup.border.width * 2
                rightMargin: vCup.border.width * 2
              }

              Repeater {
                model: vVapour.stripes

                Item {
                  width: parent.width / vVapour.stripes
                  height: parent.height * 0.9

                  Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: Math.max(30, Math.min(parent.width * 1.2, height/2))
                    height: Math.min(parent.height, 80)
                    color: vVapour.color
                    radius: dp(width/2)
                    border.color: background.color
                    border.width: 12

                    Timer {
                      onTriggered: parent.anchors.verticalCenterOffset = (Math.random() < 0.5 ? 0.02 : -dp(5))
                      running: true
                      repeat: running
                      interval: 850
                    }
                  }
                }
              }
            } // Vapour
          } // END Coffee Mug Visualization
        } // END First section


        ////
        // Second section - Inputs
        Item {
          width: parent.width == section1.width ? parent.width : (parent.width - section1.width)
          height: parent.height == section1.height ? parent.height : (parent.height - section1.height)

          Column {
            anchors {
              horizontalCenter: parent.horizontalCenter
              verticalCenter: parent.verticalCenter
            }
            width: parent.width * 0.8

            // Milk Foam
            AppText {
              height: implicitHeight
              text: " Milk foam"
              font.pixelSize: sp(16)
              color: vFoam.color
              font.bold: true
            }
            AppSlider {
              id: iSliderFoam
              width: parent.width
              knobColor: vCup.border.color
              trackColor: vVapour.color
              tintedTrackColor: vCoffee.color
              value: presets[0]["foam"]
              Behavior on value { PropertyAnimation {duration: 500} }
            }

            // Milk
            AppText {
              height: implicitHeight
              text: " Steamed Milk"
              font.pixelSize: sp(16)
              color: vMilk.color
              font.bold: true
            }
            AppSlider {
              id: iSliderMilk
              width: parent.width
              knobColor: vCup.border.color
              trackColor: vVapour.color
              tintedTrackColor: vCoffee.color
              value: presets[0]["milk"]
              Behavior on value { PropertyAnimation {duration: 500} }
            }

            // Coffee
            AppText {
              height: implicitHeight
              text: " Coffee"
              font.pixelSize: sp(16)
              color: vCoffee.color
              font.bold: true
            }
            AppSlider {
              id: iSliderCoffee
              width: parent.width
              knobColor: vCup.border.color
              trackColor: vVapour.color
              tintedTrackColor: vCoffee.color
              value: presets[0]["coffee"]
              Behavior on value { PropertyAnimation {duration: 500} }
            }

            // Divider
            Item {
              width: 1
              height: dp(20)
            }

            ////
            // Make Coffee! Button
            Rectangle {
              id: makeButton
              color: vMilk.color
              width: parent.width
              height: dp(34)
              radius: dp(12)

              AppText {
                id: makeButtonText
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "MAKE COFFEE"
                color: "#38170A"
                font.pixelSize: sp(22)
                font.bold: true
              }

              Rectangle {
                id: loadingBar
                anchors {
                  top: parent.top
                  bottom: parent.bottom
                }
                width: 0
                radius: dp(12)
                color: vCoffee.color
                opacity: 0.0

                Behavior on opacity { id: opacityBehavior; PropertyAnimation { duration: 5000 } }
                Behavior on width {
                  id: widthBehavior
                  PropertyAnimation {
                    duration: 5000
                    onRunningChanged: {
                      if (!running) {
                        makeButtonText.text = "ENJOY!"
                        waitTimer.start()
                      }
                    }
                  }
                }
              }

              RippleMouseArea {
                anchors.fill:parent
                circularBackground: false
                onClicked: {
                  if (!waitTimer.running) {
                    makeButtonText.text = "PREPARING..."
                    loadingBar.width = parent.width
                    loadingBar.opacity = 0.4
                  }
                }
              }

              Timer {
                id: waitTimer
                interval: 3000
                onTriggered: {
                  opacityBehavior.enabled = false
                  widthBehavior.enabled = false
                  makeButtonText.text = "MAKE COFFEE"
                  loadingBar.width = 0
                  loadingBar.opacity = 0
                  opacityBehavior.enabled = true
                  widthBehavior.enabled = true
                }
              }
            } // END Make Coffee Button
          } // END Column
        } // END section2
      } // END Flow
    } // END AppPage
  }

  FontLoader {
    id: secularFont
    source: "../assets/fonts/SecularOne-Regular.ttf"
  }

}
