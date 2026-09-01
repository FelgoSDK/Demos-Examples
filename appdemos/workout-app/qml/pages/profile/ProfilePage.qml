import Felgo
import QtQuick
import QtCharts
import "../../components"
import "../../model"


FlickablePage {
  id: root

  backgroundColor: Theme.secondaryBackgroundColor
  title: qsTr("Profile")

  states: [
    State {
      name: "edit"
      PropertyChanges {
        target: editProfileButton
        iconType: IconType.check
      }
      PropertyChanges {
        target: goalContainer
        visible: false
      }
      PropertyChanges {
        target: chartsGrid
        visible: false
      }
      PropertyChanges {
        target: editModeMessage
        anchors.topMargin: 0
        visible: true
      }
      PropertyChanges {
        target: changeAvatarMouseArea
        enabled: true
      }
      PropertyChanges {
        target: cleanDataButton
        visible: true
      }
      PropertyChanges {
        target: userTextField
        enabled: true
        cursorColor: Theme.tintColor
      }
    }
  ]

  rightBarItem: IconButtonBarItem {
    id: editProfileButton
    iconType: IconType.pencil

    onClicked: {
      if (root.state == "edit") {
        dataModel.updateUserName(userTextField.displayText)

        root.state = ""
      } else {
        root.state = "edit"
      }
    }
  }

  flickable.interactive: flickable.contentHeight > flickable.height
  flickable.contentHeight: contentColumn.height + editModeMessage.height

  Rectangle {
    id: editModeMessage

    anchors {
      top: parent.top
      topMargin: - height
    }

    Behavior on anchors.topMargin {
      NumberAnimation { duration: 200 }
    }

    width: parent.width
    height: dp(30)
    visible: false

    color: "#EA004FAC"

    AppText {
      anchors.centerIn: parent

      color: "white"
      font.letterSpacing: 1
      fontSize: 11
      text: qsTr("Click on avatar or name to update it")
    }
  }

  Column {
    id: contentColumn

    anchors {
      top: editModeMessage.bottom
    }

    padding: dp(Theme.contentPadding)
    spacing: dp(Theme.contentPadding)

    Row {
      spacing: dp(15)

      RoundedImage {
        id: avatarImage

        width: dp(70)
        height: width

        source: dataModel.imageForUser("currentUser")
        radius: height / 2

        MouseArea {
          id: changeAvatarMouseArea
          anchors.fill: parent

          enabled: false
          onClicked: {
            nativeUtils.displayImagePicker(qsTr("Upload avatar"))
          }
        }
      }

      Column {
        anchors.verticalCenter: parent.verticalCenter
        spacing: dp(5)

        AppTextField {
          id: userTextField

          backgroundColor: Theme.secondaryBackgroundColor
          cursorColor: "transparent"
          enabled: false
          leftPadding: 0
          font {
            bold: true
            pixelSize: dp(16)
          }

          text: dataModel.nickForUser("currentUser")
        }

        AppText {
          color: Theme.secondaryTextColor
          font.pixelSize: sp(12)
          text: qsTr("Newbie")
        }
      }
    }

    AppButton {
      id: cleanDataButton
      text: qsTr("Clear app data")
      visible: false
      flat: false

      onClicked: {
        dataModel.purge()

        avatarImage.source = dataModel.imageForUser("currentUser")
        userTextField.text = dataModel.nickForUser("currentUser")
        root.state = ""
      }
    }

    AppPaper {
      id: goalContainer
      width: root.width - 2 * dp(Theme.contentPadding)
      height: goalColumn.height + 2 * dp(Theme.contentPadding)
      radius: dp(2)
      shadowColor: "#40000000"

      Rectangle {
        anchors.fill: goalColumn
        color: "green"
        opacity: 0
      }

      Column {
        id: goalColumn
        anchors.centerIn: parent
        width: parent.width - 2 * dp(Theme.contentPadding)
        spacing: dp(5)

        AppText {
          font.pixelSize: dp(15)

          text: "Weekly progress"
        }

        AppSlider {
          id: progressSlider

          width: parent.width

          enabled: false
          handle.visible: false
          trackColor: Theme.secondaryBackgroundColor
          value: 0

          Behavior on value {
            NumberAnimation {
              duration: 1000
            }
          }
        }
      }
    }

    Grid {
      id: chartsGrid
      columns: 2
      rows: 2
      spacing: dp(Theme.contentPadding)


      ActivityStatisticsChart {
        id: runStatisticsChart
        width: (root.width - 3 * dp(Theme.contentPadding)) / 2
        height: width

        activity: "Run"
      }

      ActivityStatisticsChart {
        id: rideStatisticsChart
        width: (root.width - 3 * dp(Theme.contentPadding)) / 2
        height: width

        activity: "Ride"
      }

      ActivityStatisticsChart {
        id: swimStatisticsChart
        width: (root.width - 3 * dp(Theme.contentPadding)) / 2
        height: width

        activity: "Swim"
      }

      ActivityStatisticsChart {
        id: canoeStatisticsChart
        width: (root.width - 3 * dp(Theme.contentPadding)) / 2
        height: width

        activity: "Canoe"
      }
    }
  } // content column


  Connections {
    target: statistics

    function onLoaded() {
      root.fillCharts()
    }
  }

  Connections {
    target: nativeUtils
    enabled: navigation.currentIndex == 2

    function onImagePickerFinished(accepted, path) {
      if (accepted) {
        dataModel.updateUserAvatar(Qt.resolvedUrl(path))
        avatarImage.source = storage.getValue("userAvatar")
      }
    }
  }

  onPushed: {
    progressSlider.value = 0.6
    root.fillCharts()
  }

  function fillCharts() {
    runStatisticsChart.loadData(statistics.totalDistance,
                                statistics.activityDistanceMap[runStatisticsChart.activity])
    rideStatisticsChart.loadData(statistics.totalDistance,
                                 statistics.activityDistanceMap[rideStatisticsChart.activity])
    swimStatisticsChart.loadData(statistics.totalDistance,
                                 statistics.activityDistanceMap[swimStatisticsChart.activity])
    canoeStatisticsChart.loadData(statistics.totalDistance,
                                  statistics.activityDistanceMap[canoeStatisticsChart.activity])
  }
}
