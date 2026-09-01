import QtQuick
import Felgo
import "common"
import "details"
import "pages"
import "model"
import "logic"

Rectangle {
  id: loaderItem
  anchors.fill: parent
  color: Theme.backgroundColor

  // make navigation public (required for Felgo app demo launcher)
  property Navigation navigation: mainLoader.item && mainLoader.item.navigation

  DataModel {
    id: dataModel
    dispatcher: logic
    onInitializedChanged: logic.loadData() // load/update data after initialization
  }

  Logic {
    id: logic
  }

  ViewHelper {
    id: viewHelper
  }

  // storage for caching data
  Storage {
    id: userStorage
    clearAllAtStartup: false

    // initialize data model with stored data at startup
    Component.onCompleted: {
      logic.initializeDataModel(userStorage)
      logic.increaseLocalAppStarts() // increase local app starts after first initialization
    }
  }

  Component.onCompleted: {
    loaderTimer.start()
  }

  // load main item dynamically
  Loader {
    id: mainLoader
    anchors.fill: parent
    asynchronous: true
    visible: false
    onLoaded:{
      mainLoader.visible = true
      loadingFadeOut.start() // fade out loading screen (will reveal loaded item)
    }
  }

  Timer {
    id: loaderTimer
    interval: 500
    onTriggered: mainLoader.source = Qt.resolvedUrl("MainContentItem.qml")
  }

  // loading screen
  Rectangle {
    id: loading
    anchors.fill: parent
    color: eventDetails.pineColor
    z: 2

    AppImage {
      id: img
      source: "../assets/big-logo.png"
      width: parent.width
      fillMode: Image.PreserveAspectFit
      anchors.centerIn: parent
      anchors.verticalCenterOffset: -dp(150)
    }

    Column {
      anchors.centerIn: parent
      anchors.verticalCenterOffset: dp(150)
      spacing: dp(15)

      // Spinner
      Item {
        id: loadSpinner
        width: dp(30)
        height: dp(30)
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
          width: dp(10)
          height: dp(10)
          radius: width/2
          color: Theme.tintColor
          anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle {
          width: dp(10)
          height: dp(10)
          radius: width/2
          color: Theme.tintColor
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.bottom: parent.bottom
        }

        RotationAnimator {
          target: loadSpinner
          running: true
          loops: Animation.Infinite
          from: 0
          to: 360
          duration: 2000
        }
      }

      // fade out
      NumberAnimation {
        id: loadingFadeOut
        target: loading
        property: "opacity"
        to: 0
        duration: 300
      }
    }

    Column {
      width: parent.width
      spacing: dp(10)
      anchors.bottom: parent.bottom
      anchors.bottomMargin: dp(70) + nativeUtils.safeAreaInsets.bottom

      AppText {
        text: "This conference app is powered by"
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: sp(11)
      }

      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: dp(5)

        AppImage {
          source: "../assets/Qt_logo.png"
          height: dp(30)
          fillMode: Image.PreserveAspectFit
          anchors.verticalCenter: parent.verticalCenter
        }

        AppText {
          text: "+"
          color: "white"
          anchors.verticalCenter: parent.verticalCenter
        }

        AppImage {
          source: "../assets/felgo.png"
          height: dp(30)
          fillMode: Image.PreserveAspectFit
          anchors.verticalCenter: parent.verticalCenter
        }
      }
    }
  }

  Connections {
    target: getApplication()

    // load data if not available and device goes online
    function onIsOnlineChanged() {
      if(!dataModel.loaded && isOnline)
        loadDataTimer.start() // use timer to delay load as immediate calls might not get through (network not ready yet)
    }
  }

  Connections {
    target: notificationManager
    // display alert for upcoming sessions
    function onNotificationFired(notificationId) {
      if(notificationId !== -1) {
        // session reminder
        if(dataModel.loaded && dataModel.talks && dataModel.talks[notificationId]) {
          var title = "Session Reminder"
          var talk = dataModel.talks[notificationId]
          var textTalks = talk["title"]+" starts at "+talk.start  + "." +" in "+talk["room"]+"."
          NativeDialog.confirm(title, textTalks, function(){}, false)
        }
      }
      else {
        // default notification
        NativeDialog.confirm("The conference starts soon!", "Thanks for using our app, we wish you a great " + eventDetails.name + "!", function(){}, false)
      }
    }
  }

  // timer to load data after 1 second delay when going online
  Timer {
    id: loadDataTimer
    interval: 1000
    onTriggered: logic.loadData()
  }
}
