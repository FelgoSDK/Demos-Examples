import QtQuick 2.6
import Felgo 4.0


App {
  NavigationStack {
    FlickablePage {
      title: "Settings"
      rightBarItem: ActivityIndicatorBarItem { }

      flickable.contentWidth: width
      flickable.contentHeight: content.height + dp(20)

      Column {
        id: content
        width: parent.width
        spacing: dp(10)
        padding: dp(10)

        Row {
          AppText {
            anchors.verticalCenter: parent.verticalCenter
            text: "Theme"
            wrapMode: Text.NoWrap
          }

          AppButton {
            text: "Reset"
            flat: true
            onClicked: Theme.reset()
          }
        }

        Row {
          AppButton {
            text: "iOS"
            onClicked: Theme.platform = text.toLowerCase()
          }

          AppButton {
            text: "Android"
            onClicked: Theme.platform = text.toLowerCase()
          }

          AppButton {
            text: "Desktop"
            onClicked: Theme.platform = text.toLowerCase()
          }
        }

        AppText {
          text: "Tint Color"
          wrapMode: Text.NoWrap
        }

        Flow {
          spacing: parent.spacing

          Repeater {
            model: [ "cadetblue", "chocolate", "darkolivegreen", "darksalmon", "deepskyblue" ]

            Rectangle {
              width: dp(40)
              height: width
              radius: width * 0.25
              color: modelData
              border {
                color: "burlywood"
                width: Theme.colors.tintColor === color ? dp(2) : 0
              }

              MouseArea {
                anchors.fill: parent
                onClicked: {
                  Theme.colors.tintColor = color
                }
              }
            }
          }
        }

        AppText {
          text: "Text Color"
          wrapMode: Text.NoWrap
        }

        Flow {
          spacing: parent.spacing

          Repeater {
            model: [ "darkslategrey", "black", "navy", "slategray", "burlywood" ]

            Rectangle {
              width: dp(40)
              height: width
              radius: width * 0.25
              color: modelData
              border {
                color: "chocolate"
                width: Theme.colors.textColor === color ? dp(2) : 0
              }

              MouseArea {
                anchors.fill: parent

                onClicked: {
                  Theme.colors.textColor = modelData
                  Theme.colors.secondaryTextColor = modelData
                }
              }
            }
          }
        }

        AppText {
          text: "Background Color"
          wrapMode: Text.NoWrap
        }

        Flow {
          spacing: parent.spacing

          Repeater {
            model: [ "white", "lightgrey", "beige", "black", "salmon" ]

            Rectangle {
              id: bgColorRect
              width: dp(40)
              height: width
              radius: width * 0.25
              color: modelData
              border {
                color: Qt.colorEqual(bgColorRect.color, "white") ? "black" : "white"
                width: Theme.backgroundColor === color ? dp(2) : 0
              }

              MouseArea {
                anchors.fill: parent
                onClicked: {
                  Theme.colors.backgroundColor = modelData
                }
              }
            }
          }
        }
      }
    }
  }
}
