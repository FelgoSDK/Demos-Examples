import Felgo 3.0
import QtQuick 2.12
import "../common"
import "../controls"


Page {
  id: root

  // flickable
  AppFlickable {
    id: pageFlickable
    anchors.fill: parent
    contentHeight: content.height + dp(Theme.navigationBar.defaultBarItemPadding) * 2

    // remove focus from controls if clicked outside
    MouseArea {
      anchors.fill: parent
      onClicked: pageFlickable.forceActiveFocus()
    }

    // content
    Column {
      id: content
      width: parent.width

      Section {
        title: "Powerful Animation"
        margin: dp(20)
        spacing: dp(10)
        bottomPadding: dp(10)

        // color animation
        Rectangle {
          id: colorRect
          width: parent.width
          anchors.horizontalCenter: parent.horizontalCenter
          radius: height * 0.5
          height: dp(50)
          color: "green"

          AppText {
            text: "Color Change"
            anchors.centerIn: parent
            font.pixelSize: sp(11)
            color: "white"
          }
          PropertyAnimation {
            target: colorRect
            property: "color"
            to: "orange"
            running: true
            duration: 1000
            onStopped: {
              to = (colorRect.color.r !== 0) ? "green" : "orange"
              start()
            }
          }
        } // color animation

        // movement
        Rectangle {
          id: moveCircle
          width: dp(75)
          height: dp(50)
          radius: width * 0.5
          color: "#01a9e2"
          x: leftX

          property real leftX: 0
          property real rightX: parent.width - moveCircle.width

          AppText {
            text: "Movement"
            anchors.centerIn: parent
            font.pixelSize: sp(11)
            color: "white"
          }
          PropertyAnimation {
            target: moveCircle
            property: "x"
            to: moveCircle.rightX
            running: true
            duration: 1500
            onStopped: {
              to = (moveCircle.x > moveCircle.leftX) ? moveCircle.leftX : moveCircle.rightX
              start()
            }
            easing.type: Easing.OutBounce
          }
        }

        // rotation
        Row {
          anchors.horizontalCenter: parent.horizontalCenter
          height: dp(50)
          spacing: dp(Theme.navigationBar.defaultBarItemPadding)
          AppImage {
            id: rotateImage
            width: height
            height: parent.height
            source: "../../assets/felgo-logo.png"
            RotationAnimation {
              target: rotateImage
              running: true
              from: 0
              to: 360
              duration: 2000
              loops: Animation.Infinite
            }
          }

          AppText {
            anchors.verticalCenter: parent.verticalCenter
            text: "Rotation"
            font.pixelSize: sp(11)
          }
        }
      } // powerful animations section

      Section {
        title: "Combined Animations and Easing"
        spacing: dp(20)

        Row {
          anchors.horizontalCenter: parent.horizontalCenter
          spacing: dp(10)

          AppImage {
            id: animationImage
            width: dp(50)
            height: dp(50)
            source: "../../assets/felgo-logo.png"
            opacity: 0

            SequentialAnimation {
              running: true
              loops: Animation.Infinite

              // logo fade in
              ParallelAnimation {
                id: logoFadeIn
                readonly property int duration: 1500
                NumberAnimation {
                  target: animationImage
                  property: "opacity"
                  to: 1
                  duration: logoFadeIn.duration * 0.75
                }
                NumberAnimation {
                  target: animationImage
                  property: "scale"
                  from: 1.5
                  to: 1
                  duration: logoFadeIn.duration
                  easing.type: Easing.OutBounce
                }
                RotationAnimation {
                  target: animationImage
                  from: 180
                  to: 360
                  duration: logoFadeIn.duration * 0.5
                }
              }
              // text fade in
              ParallelAnimation {
                id: textFadeIn
                readonly property int duration: 1000
                NumberAnimation {
                  target: animationText
                  property: "opacity"
                  to: 1
                  duration: textFadeIn.duration * 0.5
                }
                NumberAnimation {
                  target: animationText
                  property: "y"
                  from: animationImage.y + animationImage.height
                  to: (animationImage.height - animationText.height) * 0.5
                  duration: textFadeIn.duration * 0.5
                  easing.type: Easing.OutExpo
                }
                ColorAnimation {
                  target: animationText
                  property: "color"
                  from: "black"
                  to: Theme.tintColor
                  duration: textFadeIn.duration
                }
              }
              PauseAnimation {
                duration: 1000
              }
              // all fade out
              ParallelAnimation {
                id: allFadeOut
                readonly property int duration: 250
                NumberAnimation {
                  target: animationImage
                  property: "opacity"
                  to: 0
                  duration: allFadeOut.duration
                }
                NumberAnimation {
                  target: animationText
                  property: "opacity"
                  to: 0
                  duration: allFadeOut.duration
                }
                NumberAnimation {
                  target: animationImage
                  property: "scale"
                  to: 1.5
                  easing.type: Easing.InExpo
                  duration: allFadeOut.duration
                }
                NumberAnimation {
                  target: animationText
                  property: "y"
                  to: animationImage.y - animationText.height
                  easing.type: Easing.InExpo
                  duration: allFadeOut.duration
                }
              }
              PauseAnimation {
                duration: 1500
              }
            }
          }

          AppText {
            id: animationText
            width: dp(180)

            y: animationImage.y + animationImage.height
            opacity: 0

            text: "Create beautiful animations in no time."
          }
        }

        CustomComboBox {
          id: easingComboBox
          anchors.horizontalCenter: parent.horizontalCenter
          implicitWidth: dp(100) + 30
          model: ["OutBounce", "OutBack", "Linear", "OutCubic"]
        }

        AppButton {
          anchors.horizontalCenter: parent.horizontalCenter
          text: "Show"
          onClicked: {
            easingDialog.open()
          }
        }
      } // combined animations & easing

      Section {
        title: "Transition Effect"
        topPadding: 0

        ListView {
          id: appListView
          width: parent.width
          height: dummyModel.count * dp(Theme.listItem.minimumHeight) + dp(1)
          clip: true
          model: ListModel {
            id: dummyModel
          }
          delegate: SimpleRow {
            id: row
            text: title
            style.showDisclosure: false
            property bool isSubItem: title.substring(0, 4) === "Sub-"

            // button to remove from list
            IconButton {
              id: closeButton
              icon: IconType.close
              anchors.right: parent.right
              anchors.verticalCenter: parent.verticalCenter
              onClicked: {
                for (var i = 0; i < dummyModel.count; i++) {
                  if (dummyModel.get(i).title === title) {
                    removeTransition.targetY = row.y - dp(20)
                    dummyModel.remove(i, 1)
                    break
                  }
                }
              }
            }

            // button add item
            IconButton {
              visible: !row.isSubItem
              icon: IconType.pluscircle
              anchors.right: closeButton.left
              anchors.verticalCenter: parent.verticalCenter
              onClicked: {
                for (var i = 0; i < dummyModel.count; i++) {
                  if (dummyModel.get(i).title === title) {
                    var subTitle = "Sub-" + title
                    var j = 1
                    while (i + j < dummyModel.count && dummyModel.get(i + j).title === subTitle) {
                      j++
                      subTitle = "Sub-" + subTitle
                    }
                    dummyModel.insert(i + j, {
                                        "title": subTitle
                                      })
                    break
                  }
                }
              }
            }
          }

          // set up transition animations
          add: Transition {
            ParallelAnimation {
              NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
              }
              NumberAnimation {
                property: "x"
                from: -width
                duration: 600
                easing.type: Easing.OutBack
              }
            }
          }
          addDisplaced: Transition {
            NumberAnimation {
              properties: "x,y"
              duration: 100
            }
          }
          remove: Transition {
            id: removeTransition
            property real targetY: 0
            ParallelAnimation {
              NumberAnimation {
                property: "opacity"
                to: 0
                duration: 400
              }
              NumberAnimation {
                properties: "scale"
                to: 0
                duration: 400
              }
              NumberAnimation {
                id: yAnim
                property: "y"
                to: removeTransition.targetY
                duration: 400
              }
            }
          }
          removeDisplaced: Transition {
            NumberAnimation {
              properties: "x,y"
              duration: 400
            }
          }

          // fill with dummy data
          Component.onCompleted: {
            reset()
          }

          function reset() {
            dummyModel.clear()
            for (var i = 0; i < 3; i++)
              dummyModel.insert(i, {
                                  "title": "Item " + i
                                })
          }
        }
        AppButton {
          horizontalMargin: 0
          verticalMargin: 0
          text: "Reset"
          anchors.horizontalCenter: parent.horizontalCenter
          onClicked: {
            appListView.reset()
          }
        }
      } // transition section
    } // content column
  } // flickable

  // scroll indicator
  ScrollIndicator {
    flickable: pageFlickable
    z: 1
  }

  Dialog {
    id: easingDialog

    title: "Animation Easing"
    positiveActionLabel: "Cool!"
    negativeAction: false
    onAccepted: close()
    scaleAnimation.easing.type: Easing[easingComboBox.currentText]
    scaleAnimation.duration: easingComboBox.currentIndex === 0 ? 500 : 300

    AppText {
      y: dp(50)
      width: parent.width - 2 * dp(Theme.navigationBar.defaultBarItemPadding)
      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: AppText.AlignHCenter
      text: "This dialog was opened with easing type \"" + easingComboBox.currentText + "\"."
    }
  }
}
