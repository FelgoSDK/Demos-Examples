import Felgo 3.0
import QtQuick 2.0

App {
  NavigationStack {
    Page {
      title: "On-Demand Dialog"

      AppButton {
        text: "Open"
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: myOverlay.open()
      }

      Component {
        id: dialogComponent
        Dialog {
          backgroundItem: null // no background, covered by overlay

          // custom Dialog configuration
          title: "Do you think this is awesome?"
          positiveActionLabel: "Yes"
          negativeActionLabel: "No"
          onCanceled: title = "Think again!"
          onAccepted: close()

          AppText {
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            text: "What do you say?"
          }
        }
      }

      AppOverlay {
        id: myOverlay
        sourceItem: dialogComponent

        // open/close the created Dialog item with the overlay
        openAnimation: ScriptAction { script: myOverlay.item.open() }
        closeAnimation: ScriptAction { script: myOverlay.item.close() }

        // close the overlay when the user closes the Dialog item
        onOpening: item.closing.connect(myOverlay.close)
        onItemWillDestroy: item.closing.disconnect(myOverlay.close)
      }
    }
  }
}
