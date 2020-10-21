import Felgo 3.0
import QtQuick 2.0
import QtCharts 2.3
import QtGraphicalEffects 1.0
import "../../components"
import "../../model"


FlickablePage {
  id: root

  property Workout workout: null

  signal canceled()

  title: qsTr("Save Activity")

  leftBarItem: IconButtonBarItem {
    color: Theme.textColor
    icon: IconType.arrowleft

    onClicked: {
      root.workout.resume()
      root.navigationStack.pop()
    }
  }

  rightBarItem: TextButtonBarItem {
    color: Theme.textColor
    text: qsTr("Save")

    onClicked: {
      trophyAnimation.start()
    }
  }

  flickable.contentHeight: contentColumn.height
  flickable.interactive: flickable.contentHeight > flickable.height && recordBackground.color == "transparent"

  Column {
    id: contentColumn
    width: parent.width
    spacing: dp(20)

    SimpleSection {
      title: qsTr("How did it go?")
    }

    AppTextField {
      id: workoutTitleTextField

      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width - 2 * dp(Theme.contentPadding)

      placeholderText: qsTr("Title your workout")
    }

    SimpleSection {
      title: qsTr("Take a look at statistics")
    }

    WorkoutParameters {
      background.color: Theme.backgroundColor
      shadow.visible: false
      workout: root.workout
    }
  }

  Rectangle {
    id: recordBackground

    width: root.width
    height: root.height

    color: "transparent"

    Column {
      id: recordTextColumn

      anchors {
        centerIn: parent
        verticalCenterOffset: - parent.height / 4
      }
      opacity: 0
      spacing: dp(10)

      AppText {
        anchors.horizontalCenter: parent.horizontalCenter
        font {
          bold: true
          pixelSize: sp(20)
        }

        text: {
          if (root.workout.distance < 0.3) {
            // it means that user didn't move and we will mock record event
            return (Math.random() * (15 - 4) + 15).toFixed(1) + " km"
          }

          return root.workout.distance + " km"
        }
      }

      AppText {
        anchors.horizontalCenter: parent.horizontalCenter
        font {
          bold: true
          pixelSize: sp(16)
        }

        text: qsTr("It's your record!")
      }
    }

    AppImage {
      id: trophyImage
      anchors.centerIn: parent
      width: dp(50)
      height: dp(50)
      visible: recordTextColumn.opacity > 0

      source: "../../../assets/icons/trophy.png"
    }

    MouseArea {
      anchors.fill: parent
      visible: trophyImage.visible

      onClicked: {
        root.workout.save(workoutTitleTextField.displayText)
        root.navigationStack.clearAndPush(root.navigationStack.initialPage)
        workoutModal.close()
      }
    }

    SequentialAnimation {
      id: trophyAnimation

      ParallelAnimation {
        PropertyAnimation {
          target: trophyImage
          properties: "width,height"
          to: dp(120)
          duration: 400
        }
        PropertyAnimation {
          target: recordTextColumn
          property: "opacity"
          to: 1
          duration: 400
        }
        PropertyAnimation {
          target: recordBackground
          property: "color"
          from: "#00FFFFFF"
          to: "#D0FFFFFF"

          duration: 300
        }
      }

      PropertyAnimation {
        target: trophyImage
        property: "rotation"
        to: 30
        duration: 225
        easing.type: Easing.InOutCubic
      }

      SequentialAnimation {
        loops: Animation.Infinite
        PropertyAnimation {
          target: trophyImage
          property: "rotation"
          from: 30
          to: -30
          duration: 450
          easing.type: Easing.InOutCubic
        }
        PropertyAnimation {
          target: trophyImage
          property: "rotation"
          from: -30
          to: 30
          duration: 450
          easing.type: Easing.InOutCubic
        }
      }
    }
  }
}
