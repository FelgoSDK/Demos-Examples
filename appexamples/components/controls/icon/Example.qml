import QtQuick
import Felgo


App {
  NavigationStack {
    AppPage {
      title: "AppIcon"

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

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.angellist
          color: "salmon"
          size: dp(35)
        }

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.adjust
        }

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.bell
          color: "goldenrod"
        }

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.bicycle
          color: "deepskyblue"
        }

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.leaf
          color: "darkgreen"
        }

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.ticket
          color: "blueviolet"
        }

        AppIcon {
          anchors.horizontalCenter: parent.horizontalCenter
          iconType: IconType.camera
          color: "dimgray"
        }
      }
    }
  }
}
