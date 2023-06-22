import QtQuick 2.8
import QtQuick.Controls 2.2 as QC2
import Felgo 4.0

App {
  id: app

  NavigationStack {
    AppPage {
      title: "Custom AppListItem"
      backgroundColor: Theme.colors.secondaryBackgroundColor

      AppFlickable {
        anchors.fill: parent
        contentHeight: column.height
        bottomMargin: nativeUtils.safeAreaInsets.bottom

        Column {
          id: column
          width: parent.width

          SimpleSection {
            title: "Standard Items"
          }

          AppListItem {
            text: "First"
            rightText: "Longer rightText, really long"
          }
          AppListItem {
            text: "Second with longer text"
            rightText: "Hi"
          }
          AppListItem {
            text: "An active item"
            detailText: "This is disabled so it cannot be clicked"
            active: true
            enabled: false
            lastInSection: true
          }

          SimpleSection {
            title: "Images"
          }

          AppListItem {
            text: "Using an image"
            image: "https://via.placeholder.com/300"
          }
          AppListItem {
            text: "Muted with image"
            image: "https://via.placeholder.com/300"
            muted: true
          }

          AppListItem {
            text: "Image with"
            detailText: "some detailText"
            image: "https://via.placeholder.com/300"
            lastInSection: true
          }

          SimpleSection {
            title: "Custom Items"
          }

          AppListItem {
            text: "Oh look, an icon"
            rightText: "Nice!"
            showDisclosure: false

            leftItem: AppIcon {
              iconType: IconType.heart
              anchors.verticalCenter: parent.verticalCenter
              width: dp(26)
            }
          }
          AppListItem {
            text: "Wi-Fi"
            rightText: "Connected"

            leftItem: Rectangle {
              color: Theme.colors.tintColor
              radius: dp(5)
              width: dp(26)
              height: width
              anchors.verticalCenter: parent.verticalCenter

              AppIcon {
                iconType: IconType.wifi
                anchors.centerIn: parent
                color: "white"
              }
            }
          }
          AppListItem {
            text: "General"

            leftItem: Rectangle {
              color: "grey"
              radius: dp(5)
              width: dp(26)
              height: width
              anchors.verticalCenter: parent.verticalCenter

              AppIcon {
                iconType: IconType.cog
                anchors.centerIn: parent
                color: "white"
              }
            }

            rightItem: Rectangle {
              color: "red"
              radius: width/2
              width: dp(22)
              height: width
              anchors.verticalCenter: parent.verticalCenter

              AppText {
                anchors.centerIn: parent
                color: "white"
                text: "1"
              }
            }
          }
          AppListItem {
            text: "Some Wifi Name"
            showDisclosure: false

            leftItem: AppIcon {
              iconType: IconType.check
              color: Theme.colors.tintColor
              width: dp(26)
              anchors.verticalCenter: parent.verticalCenter
            }

            rightItem: Row {
              spacing: dp(5)
              anchors.verticalCenter: parent.verticalCenter

              AppIcon {
                iconType: IconType.lock
                width: sp(26)
                height: width
                anchors.verticalCenter: parent.verticalCenter
              }
              AppIcon {
                iconType: IconType.wifi
                width: sp(26)
                height: width
                anchors.verticalCenter: parent.verticalCenter
              }
              IconButton {
                iconType: IconType.info
                width: sp(26)
                height: width
                size: dp(22)
                anchors.verticalCenter: parent.verticalCenter
              }
            }
          }
          AppListItem {
            id: listItem
            showDisclosure: false
            mouseArea.enabled: false
            topPadding: 0
            bottomPadding: 0

            leftItem: AppIcon {
              iconType: IconType.moono
              width: sp(26)
              height: width
              anchors.verticalCenter: parent.verticalCenter
            }

            textItem: AppSlider {
              height: dp(45)
              width: listItem.textItemAvailableWidth
              value: 0.3
            }

            rightItem: AppIcon {
              iconType: IconType.suno
              width: sp(26)
              height: width
              anchors.verticalCenter: parent.verticalCenter
            }
          }
          AppListItem {
            text: "Custom detailText item"
            image: "https://via.placeholder.com/300"
            textVerticalSpacing: dp(10)
            lastInSection: true

            detailTextItem: Row {
              spacing: dp(10)
              AppIcon {
                iconType: IconType.heart
              }
              AppIcon {
                iconType: IconType.paperplane
              }
              AppIcon {
                iconType: IconType.automobile
              }
            }
          }

          SimpleSection {
            title: "Switches"
          }

          AppListItem {
            text: "This is a switch"
            showDisclosure: false
            mouseArea.enabled: false

            rightItem: AppSwitch {
              anchors.verticalCenter: parent.verticalCenter
              checked: true
            }
          }
          AppListItem {
            text: "Whole item toggles switch"
            detailText: "Switch checked: " + innerSwitch.checked
            showDisclosure: false

            rightItem: AppSwitch {
              id: innerSwitch
              anchors.verticalCenter: parent.verticalCenter
              enabled: false
            }

            onSelected: {
              innerSwitch.toggle()
            }
          }
          AppListItem {
            text: "A muted item"
            muted: true
            showDisclosure: false
            lastInSection: true

            rightItem: AppSwitch {
              anchors.verticalCenter: parent.verticalCenter
            }
          }

          SimpleSection {
            title: "Radio Button Selected: " + ratioButtonGroup.checkedButton.value
          }

          QC2.ButtonGroup {
            id: ratioButtonGroup
            buttons: [radio1, radio2, radio3]
          }

          AppListItem {
            text: "First Option"
            showDisclosure: false

            leftItem: AppRadio {
              id: radio1
              checked: true
              value: "Option 1"
              anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
              if(!radio1.checked) radio1.toggle()
            }
          }

          AppListItem {
            text: "Second Option"
            showDisclosure: false

            leftItem: AppRadio {
              id: radio2
              value: "Option 2"
              anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
              if(!radio2.checked) radio2.toggle()
            }
          }

          AppListItem {
            text: "Third Option"
            showDisclosure: false
            lastInSection: true

            leftItem: AppRadio {
              id: radio3
              value: "Option 3"
              anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
              if(!radio3.checked) radio3.toggle()
            }
          }

          SimpleSection {
            title: "Checkboxes"
          }

          AppListItem {
            text: "First Option"
            showDisclosure: false

            rightItem: AppCheckBox {
              id: checkBox1
              anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
              checkBox1.checked = !checkBox1.checked
            }
          }

          AppListItem {
            text: "Second Option"
            showDisclosure: false

            rightItem: AppCheckBox {
              id: checkBox2
              checked: true
              anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
              checkBox2.checked = !checkBox2.checked
            }
          }

          AppListItem {
            text: "Third Option"
            showDisclosure: false
            lastInSection: true

            rightItem: AppCheckBox {
              id: checkBox3
              anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
              checkBox3.checked = !checkBox3.checked
            }
          }
        }
      }
    }
  }
}
