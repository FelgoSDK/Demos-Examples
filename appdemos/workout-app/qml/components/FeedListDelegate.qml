import Felgo 3.0
import QtQuick 2.8
import "../Helpers.js" as Helpers


AppPaper {
  id: root

  property int modelIndex: 0
  property var modelItem: null

  signal commentClicked()
  signal postClicked()

  width: parent.width
  height: column.height + footer.height + footer.anchors.topMargin

  elevated: mouseArea.pressed
  background.color: Theme.backgroundColor
  shadowColor: "#40000000"

  states: [
    State {
      name: "postPage"
      PropertyChanges {
        target: footer
        anchors.topMargin: dp(30)
        color: Theme.backgroundColor
      }
      PropertyChanges {
        target: root
        shadow.visible: false
      }
      PropertyChanges {
        target: topFooterDivider
        visible: true
      }
      PropertyChanges {
        target: bottomFooterDivider
        visible: true
      }
      PropertyChanges {
        target: commentsNumberText
        visible: false
      }
      PropertyChanges {
        target: mouseArea
        visible: false
      }
      PropertyChanges {
        target: contentLoader
        isOnPostPage: true
      }
    }
  ]

  Column {
    id: column
    width: parent.width
    spacing: dp(10)

    Row {
      id: header

      width: parent.width
      height: dp(60)

      leftPadding: dp(Theme.contentPadding)
      spacing: Theme.contentPadding

      RoundedImage {
        id: avatarImage
        anchors.verticalCenter: parent.verticalCenter

        width: dp(40)
        height: width

        source: dataModel.imageForUser(modelItem.author)
        radius: height / 2
      }

      Column {
        anchors.verticalCenter: parent.verticalCenter

        spacing: dp(2)

        AppText {
          id: authorText
          font.bold: true
          font.pixelSize: sp(12)
          text: dataModel.nickForUser(modelItem.author)
        }

        Row {
          height: dp(20)
          spacing: dp(4)

          AppImage {
            width: parent.height
            height: width

            source: visible ? "../../assets/icons/sports/" + modelItem.activity + ".png" : ""
            visible: modelItem.activity !== undefined
          }

          AppText {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: sp(10)
            text: "July 28, 2020 at 6:16 PM"
          }
        }
      }
    }

    AppText {
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width - 2 * dp(Theme.contentPadding)

      font.bold: modelItem.type === "Workout"
      text: modelItem.content
      wrapMode: Text.Wrap
    }

    Loader {
      id: workoutDetailsLoader

      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width - 2 * dp(Theme.contentPadding)
      height: dp(60)

      active: modelItem.type === "Workout"
      visible: active
      sourceComponent: Item {
        anchors.fill: parent

        Row {
          height: parent.height

          WorkoutParameterTile {
            height: parent.height

            state: "feed"
            title: "Time"
            value: Helpers.formatTime(modelItem.workout.timePassed)
          }

          Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: dp(1)
            height: dp(30)

            color: Theme.secondaryTextColor
          }

          WorkoutParameterTile {
            height: parent.height

            state: "feed"
            title: "Distance"
            value: modelItem.workout.distance.toFixed(2) + " km"
          }

          Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: dp(1)
            height: dp(30)

            color: Theme.secondaryTextColor
          }

          WorkoutParameterTile {
            height: parent.height

            state: "feed"
            title: "Avg. speed"
            value: Helpers.averageSpeed(modelItem.workout.distance, modelItem.workout.timePassed)
          }
        }
      }
    }

    Loader {
      id: contentLoader

      property bool isOnPostPage: false

      width: root.width
      height: !!item ? item.height : 0

      active: false
      visible: (!!modelItem.image && modelItem.image !== "") || !!modelItem.workout

      onActiveChanged: {
        contentLoader.source = modelItem.type === "Post" ?
              Qt.resolvedUrl("./FeedListDelegatePost.qml") :
              Qt.resolvedUrl("./FeedListDelegateWorkout.qml")
      }
    }

    AppText {
      id: commentsNumberText
      width: parent.width

      color: Theme.secondaryTextColor
      font.pixelSize: sp(12)
      horizontalAlignment: Text.AlignRight
      rightPadding: dp(Theme.contentPadding)

      text: modelItem.comments.length + " comment" + (modelItem.comments.length > 1 ? "s" : "")
      visible: modelItem.comments.length > 0
    }
  }

  Rectangle {
    id: footer

    anchors {
      top: column.bottom
      topMargin: modelItem.comments.length > 0 || (modelItem.type == "Post" && modelItem.image == "") ? column.spacing : 0
    }

    width: parent.width
    height: dp(45)

    color: Theme.secondaryBackgroundColor

    AppButton {
      anchors {
        horizontalCenter: parent.horizontalCenter
        horizontalCenterOffset: - parent.width / 4
      }

      minimumWidth: parent.width / 2
      height: parent.height

      flat: true
      icon: !!modelItem.liked ? IconType.thumbsup : IconType.thumbsoup
      textColor: Theme.secondaryTextColor
      verticalMargin: 0

      onClicked: {
        dataModel.likeFeed(modelIndex)
      }
    }

    AppButton {
      anchors {
        horizontalCenter: parent.horizontalCenter
        horizontalCenterOffset: parent.width / 4
      }

      minimumWidth: parent.width / 2
      height: parent.height

      flat: true
      icon: IconType.commento
      textColor: Theme.secondaryTextColor
      verticalMargin: 0

      onClicked: {
        root.commentClicked()
      }
    }

    Rectangle {
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      width: 1
      height: parent.height / 2
      color: Theme.listItem.dividerColor
    }

    Rectangle {
      id: topFooterDivider

      width: parent.width
      height: 1
      visible: false

      color: Theme.listItem.dividerColor
    }

    Rectangle {
      id: bottomFooterDivider

      anchors.top: parent.bottom

      width: parent.width
      height: 1
      visible: false

      color: Theme.listItem.dividerColor
    }
  }

  RippleMouseArea {
    id: mouseArea
    width: column.width * 3

    anchors {
      top: parent.top
      bottom: footer.top
    }

    circularBackground: false
    hoverEffectRadius: 0
    radius: 0
    pressedDuration: 300

    onClicked: {
      root.postClicked()
    }
  }

  Connections {
    target: dataModel

    onUserDataChanged: {
      if (modelItem.author !== "currentUser") {
        return
      }

      avatarImage.source = dataModel.imageForUser(modelItem.author)
      authorText.text = dataModel.nickForUser(modelItem.author)
    }
  }

  Component.onCompleted: {
    // condition to not load loader content if there is no image for regular post
    if (modelItem.type === "Post") {
      if (modelItem.image == "" || modelItem.image === undefined) {
        return
      }
    }

    contentLoader.active = true
  }
}
