import QtQuick 2.4
import Felgo 3.0

ListPage {
  id: page
  title: personData.text

  property var personData: undefined

  property var newMsgs: []

  property int numRepeats: 1

  property int lastSentMsgIdx: -1

  readonly property int numLoadedItems: blindTextMsgs.length
  property var blindTextMsgs: [
    { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
    { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
    { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false },
    { text: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.", me: false },
    { text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.", me: true },
    { text: "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words.", me: false }
  ]

  titleItem: Row {
    spacing: dp(Theme.navigationBar.defaultBarItemPadding) / 2

    RoundedImage {
      source: personData.image
      height: dp(Theme.navigationBar.defaultIconSize) * 2
      width: height
      radius: height
      anchors.verticalCenter: parent.verticalCenter
    }

    AppText {
      text: page.title
      fontSize: Theme.navigationBar.titleTextSize
      font.bold: Theme.navigationBar.titleTextBold
      font.family: Theme.navigationBar.titleTextFont
      color: Theme.navigationBar.titleColor
      anchors.verticalCenter: parent.verticalCenter
    }
  }

  model: JsonListModel {
    source: {
      var model = newMsgs
      for(var i = 0; i < numRepeats; i++) {
        model = blindTextMsgs.concat(model)
      }
      return model
    }
  }

  Component.onCompleted: {
    page.listView.positionViewAtEnd()
    page.listView.contentY = page.listView.contentHeight
  }

  backgroundColor: "#EFE7DE"
  listView.backgroundColor: backgroundColor
  listView.boundsBehavior: Flickable.StopAtBounds
  listView.anchors.bottomMargin: bottomBar.height
  listView.bottomMargin: 0
  listView.header: VisibilityRefreshHandler {
    onRefresh: {
      // Store old content height and add height of VisibilityRefreshHandler
      // to restore scroll position after loading new content
      loadTimer.oldContentHeight = page.listView.contentHeight + height
      loadTimer.start()
    }
  }

  onPopped: Qt.inputMethod.hide()
  onHeightChanged: listView.positionViewAtEnd()

  //fake loading with timer
  Timer {
    id: loadTimer
    property real oldContentHeight
    interval: 2000
    onTriggered: {
      // Add more fake text messages
      numRepeats++
      // Calculate and restore scroll position
      var pos = page.listView.contentHeight - oldContentHeight
      page.listView.contentY = pos
    }
  }

  // One message
  delegate: Item {
    id: bubble
    width: parent.width
    height: bg.height + dp(20)

    // position container
    Item {
      x: model.me ? (bubble.width - width - dp(10)) : dp(10)
      width: bg.width
      y: dp(10)

      // draggable message bubble
      Rectangle {
        id: bg
        width: innerText.width + dp(20)
        height: innerText.implicitHeight + dp(20)

        Component.onCompleted: {
          if(index === lastSentMsgIdx) {
            visible = false
            showAnimation.start()
          }
        }

        SequentialAnimation {
          id: showAnimation
          PauseAnimation { duration: 100 }
          ScriptAction {
            script: {
              listView.flick(0, -listView.maximumFlickVelocity)
              bg.visible = true
            }
          }
          PropertyAnimation {
            target: bg
            property: "x"
            from: bg.width
            to: 0
            easing.type: Easing.OutBack
            duration: 350
          }
        }

        property color pressedColor: (model.me ? "#F2FFD8" : "#F9F9F9")
        color: swipeArea.pressed ? pressedColor : (model.me ? "#E1FFC7" : "white")
        radius: dp(10)

        Text {
          id: innerText
          x: dp(10)
          y: dp(10)
          width: Math.min(innerText.implicitWidth, bubble.parent.width * 0.75)
          wrapMode: Text.WordWrap
          text: model.text
          font.pixelSize: sp(16)
          color: "#1d211a"
        }

        MouseArea {
          id: swipeArea
          anchors.fill: parent
          anchors.leftMargin: Theme.isIos && !model.me ? dp(24) : 0

          drag.target: bg
          drag.axis: Drag.XAxis
          drag.minimumX: model.me ? -gestureThreshold : 0
          drag.maximumX: model.me ? 0 : gestureThreshold

          signal bubbleSwipe()
          onBubbleSwipe: copyTextFromBubble(model)

          // swipe detection
          property bool swipeStarted: false
          property real startX: 0
          property real gestureThreshold: dp(24)
          onPressed: {
            if(!swipeStarted) {
              startX = mouse.x
              swipeStarted = true
            }
          }
          onReleased: {
            if(!swipeStarted)
              return

            swipeStarted = false
            let diff = startX - mouse.x
            if(Math.abs(diff) > gestureThreshold && Math.abs(bg.x) > 0) {
              bubbleSwipe()
            }
            bg.x = 0
          }
        }

        Behavior on x {
          PropertyAnimation { duration: 100 }
        }
      }
    }
  }

  // mouse area to dismiss keyboard
  MouseArea {
    anchors.fill: parent
    anchors.bottomMargin: bottomBar.height
    onClicked: { Qt.inputMethod.hide(); listView.positionViewAtEnd() }
    enabled: app.keyboardVisible
  }

  // Area for Input field
  Item {
    id: bottomBar
    anchors.bottom: parent.bottom
    width: parent.width
    height: dp(16) + controls.height + (keyboardVisible ? 0 : nativeUtils.safeAreaInsets.bottom)
    anchors.horizontalCenter: parent.horizontalCenter
    //    anchors.bottomMargin: Theme.isAndroid || !app.keyboardVisible ? nativeUtils.safeAreaInsets.bottom + dp(8) : dp(8)

    // background
    Rectangle {
      anchors.fill: parent
      color: Theme.navigationTabBar.backgroundColor
      visible: Theme.isIos
    }

    // divider
    Rectangle {
      width: parent.width
      height: 1
      color: "#dfdfdf"
      visible: Theme.isIos
    }

    // controls
    Item{
      id: controls
      width: parent.width
      height: Theme.isIos ? dp(36) :dp(48)
      anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        margins: dp(8)
      }

      Rectangle{
        height: parent.height
        anchors {
          left: parent.left
          right: sendButton.visible ? sendButton.left : parent.right
          rightMargin: sendButton.visible ? 0 : dp(8)
          leftMargin: dp(8)
        }

        radius: height/2
        color: "white"
        border.color: "#dfdfdf"
        border.width: 1

        AppTextField {
          id: inputText
          anchors { fill: parent; leftMargin: dp(14); rightMargin: dp(14) }
          font.pixelSize: sp(14)
          placeholderText: "Type a message ..."
          verticalAlignment: Text.AlignVCenter
          underlineColor: "transparent"
          backgroundColor: "transparent"
          onAccepted: sendMsg()
        }
      }

      IconButton {
        id: sendButton
        icon: IconType.chevroncircleright
        size: dp(24)
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        visible: opacity > 0
        opacity: inputText.displayText == "" ? 0 : 1
        onClicked: sendMsg()
      }
    }
  }

  function copyTextFromBubble(bubbleData) {
    inputText.text = bubbleData.text
    listView.positionViewAtEnd()
    if(inputText.text !== "") {
      inputText.forceActiveFocus()
    }
  }

  function sendMsg() {
    inputText.text = inputText.displayText
    if(inputText.text !== "") {
      lastSentMsgIdx = model.count
      newMsgs = newMsgs.concat({me: true, text: inputText.text})
      inputText.text = ""
      Qt.inputMethod.hide()
      inputText.focus = false
    }
  }
}
