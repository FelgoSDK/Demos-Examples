import QtQuick 2.0
import Felgo 3.0


App {
  NavigationStack {
    Page {
      title: "Icon"

      AppText {
        anchors {
          bottom: column.top
          bottomMargin: dp(20)
          horizontalCenter: column.horizontalCenter
        }

        text: "Several icons:"
      }

      Column {
        id: column
        spacing: dp(20)
        anchors.centerIn: parent

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.angellist
          color: "salmon"
          size: dp(35)
        }

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.adjust
        }

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.bell
          color: "goldenrod"
        }

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.bicycle
          color: "deepskyblue"
        }

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.leaf
          color: "darkgreen"
        }

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.ticket
          color: "blueviolet"
        }

        Icon {
          anchors.horizontalCenter: parent.horizontalCenter
          icon: IconType.camera
          color: "dimgray"
        }
      }
    }
  }
}
