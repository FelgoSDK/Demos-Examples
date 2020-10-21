import QtQuick 2.0
import QtQuick.Dialogs 1.2
import Felgo 3.0
import "../common"


AppModal {
  id: themeModal


  fullscreen: false
  modalHeight: dp(380) + nativeUtils.safeAreaInsets.bottom

  NavigationStack {
    Page {
      title: "Customize this app"
      rightBarItem: TextButtonBarItem {
        text: "Close"
        textItem.font.pixelSize: sp(16)
        onClicked: themeModal.close()
      }

      Column {
        id: themeColumn
        width: parent.width

        Section {
          title: "Select theme"

          SimpleRow {
            text: "iOS Theme"
            showDisclosure: false
            onSelected: {
              Theme.platform = "ios"
              Theme.colors.statusBarStyle = Theme.colors.statusBarStyleBlack
            }

            Icon {
              icon: IconType.check
              visible: Theme.isIos
              anchors.right: parent.right
              anchors.rightMargin: dp(Theme.contentPadding)
              anchors.verticalCenter: parent.verticalCenter
            }
          }

          SimpleRow {
            text: system.isPlatform(System.IOS) ? "Materal Theme" : "Android Theme"
            showDisclosure: false
            onSelected: {
              Theme.platform = "android"
              Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite
            }

            Icon {
              icon: IconType.check
              visible: Theme.isAndroid
              anchors.right: parent.right
              anchors.rightMargin: dp(Theme.contentPadding)
              anchors.verticalCenter: parent.verticalCenter
            }
          }

          SimpleRow {
            text: "Desktop Theme"
            showDisclosure: false
            onSelected: {
              Theme.platform = "windows"
              Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite
            }

            Icon {
              icon: IconType.check
              visible: Theme.isDesktop
              anchors.right: parent.right
              anchors.rightMargin: dp(Theme.contentPadding)
              anchors.verticalCenter: parent.verticalCenter
            }
          }
        } // theme selection section

        Section {
          title: "Select tint color"
          bottomPadding: dp(50)

          Row {
            anchors.horizontalCenter: parent.horizontalCenter

//            columns: 2
            spacing: dp(20)

            Rectangle {
              id: blueCircle
              width: dp(30)
              height: width
              color: Theme.isIos ? "#007aff" : (Theme.isAndroid ? "#3f51b5" : "#01a9e2") // felgo blue
              opacity: Theme.colors.tintColor == blueCircle.color ? 1 : 0.5
              radius: height / 2

              MouseArea {
                anchors.fill: parent
                onClicked: Theme.colors.tintColor = blueCircle.color
              }
            }

            Rectangle {
              id: greenCircle
              width: dp(30)
              height: width
              color: "green"
              opacity: Theme.colors.tintColor == greenCircle.color ? 1 : 0.5
              radius: height / 2

              MouseArea {
                anchors.fill: parent
                onClicked: Theme.colors.tintColor = greenCircle.color
              }
            }

            Rectangle {
              id: redCircle
              width: dp(30)
              height: width
              color: "red"
              opacity: Theme.colors.tintColor == redCircle.color ? 1 : 0.5
              radius: height / 2

              MouseArea {
                anchors.fill: parent
                onClicked: Theme.colors.tintColor = redCircle.color
              }
            }

            Rectangle {
              id: blackCircle
              width: dp(30)
              height: width
              color: "black"
              opacity: Theme.colors.tintColor == blackCircle.color ? 1 : 0.5
              radius: height / 2

              MouseArea {
                anchors.fill: parent
                onClicked: Theme.colors.tintColor = blackCircle.color
              }
            }
          }
        }
      }
    }
  }
}
