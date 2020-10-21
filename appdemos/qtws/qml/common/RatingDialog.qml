import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import Felgo 3.0
import "../common"

// feedback window to contact Felgo
Dialog {
  id: ratingDialog
  negativeAction: true
  negativeActionLabel: "Close"
  positiveActionLabel: "Rate"
  autoSize: true
  outsideTouchable: false

  onCanceled: {
    logic.setFeedBackSent(true)
    ratingDialog.close()
  }
  onAccepted: {
    amplitude.logEvent("RateInStore")
    logic.setFeedBackSent(true)

    // open the store site to rate the game instead
    ratingDialog.close()

    openUrlTimeout.start()
  }

  Item {
    id: contentArea
    width: parent.width
    height: content.height

    Column {
      id: content
      width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding)*2
      anchors.horizontalCenter: parent.horizontalCenter
      topPadding: dp(15)
      spacing: dp(10)
      bottomPadding: dp(15)

      // rating header
      Text {
        id: ratingText
        horizontalAlignment: Theme.isIos ? Text.AlignHCenter : Text.AlignLeft
        anchors.horizontalCenter: Theme.isIos ? parent.horizontalCenter : undefined
        text: "Rate This App"
        color: Theme.textColor
        font.pixelSize: sp(18)
        width: parent.width * 0.8//- anchors.topMargin * 2
        wrapMode: Text.Wrap
        font.bold: true
      }

      // rating note
      Text {
        id: ratingNote
        horizontalAlignment: Theme.isIos ? Text.AlignHCenter : Text.AlignLeft
        anchors.horizontalCenter: Theme.isIos ? parent.horizontalCenter : undefined
        text: "Great that you like it! Please support us by rating the app in the store."
        color: Theme.textColor
        font.pixelSize: sp(14)
        width: parent.width * 0.8//- 20
        wrapMode: Text.Wrap
      }

//      AppButton {
//        text: "I already rated this app"
//        flat: true
//        anchors.horizontalCenter: parent.horizontalCenter
//        textSize: sp(12)
//        onClicked: {
//          logic.setFeedBackSent(true)

//          // close the window
//          ratingDialog.close()
//        }
//      }

//      // spacer
//      Item {
//        width: parent.width
//        height: parent.spacing
//      }
    }

    Timer {
      id: openUrlTimeout
      interval: 500
      onTriggered: {
        nativeUtils.openUrl(ratingUrl)
      }
    }

  } // content area
}
