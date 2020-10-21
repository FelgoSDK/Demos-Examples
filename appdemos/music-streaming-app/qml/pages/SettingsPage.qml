import QtQuick 2.0
import Felgo 3.0

FlickablePage {
  id: root

  property bool isPremiumAccount: !!storage.getValue("isPremium")

  title: qsTr("Settings")
  flickable.contentHeight: column.height
  flickable.anchors.bottomMargin: actuallyPlayingOverlay.visible ? actuallyPlayingOverlay.height : 0

  Column {
    id: column

    anchors {
      top: parent.top
      topMargin: dp(40)
    }

    width: parent.width
    spacing: dp(15)

    AppText {
      id: isPremiumText
      anchors.horizontalCenter: parent.horizontalCenter

      font.bold: true
      fontSize: 22
      text: root.isPremiumAccount ? "Premium Account" : "Free Account"
    }

    AppButton {
      anchors.horizontalCenter: parent.horizontalCenter

      backgroundColor: Theme.textColor
      textColor: Theme.isIos ? Theme.textColor : Theme.backgroundColor
      textColorDisabled: Theme.tintColor
      enabled: !root.isPremiumAccount
      icon: root.isPremiumAccount ? IconType.diamond : ""
      text: root.isPremiumAccount ? "" : "GO PREMIUM"
      radius: height / 2

      onClicked: {
        storage.setValue("isPremium", true)
        root.isPremiumAccount = !!storage.getValue("isPremium")
      }
    }

    Column {
      width: parent.width

      Repeater {
        model:  [
          {
            text: "Crossfade",
            detailText: "Crossfade between songs"
          },
          {
            text: "Gapless",
            detailText: "Gapless palyback of songs"
          },
          {
            text: "Automix",
            detailText: "Smooth transitions between songs"
          },
          {
            text: "Show unplayable songs",
            detailText: "Shows songs that are unplayable"
          }

        ]

        SimpleRow {
          id: settingsRow

          property bool isChecked: false

          style: StyleSimpleRow {
            backgroundColor: Theme.colors.backgroundColor
            selectedBackgroundColor: backgroundColor
            textColor: Theme.colors.textColor
            detailTextColor: Theme.colors.secondaryTextColor
            selectedTextColor: Theme.colors.secondaryTextColor
            dividerHeight: 0
          }
          showDisclosure: false

          // Toggle the checked state on click, this will also update the AppSwitch
          onSelected: isChecked = !isChecked

          AppSwitch {
            // Disable the button and let the SimpleRow clicks handle the checked state
            enabled: false
            updateChecked: false
            checked: settingsRow.isChecked

            anchors {
              right: parent.right
              rightMargin: dp(Theme.contentPadding)

              verticalCenter: parent.verticalCenter
            }
            backgroundColorOn: Theme.colors.tintColor
            backgroundColorOff: "#333"
            backgroundBorderColor: "transparent"
            knobColorOn: "#fff"
          }
        }
      }

      AppButton {
        anchors.horizontalCenter: parent.horizontalCenter

        verticalPadding: dp(8)
        horizontalPadding: dp(30)

        text: "Clear settings"
        icon: IconType.paintbrush
        radius: height / 2

        onClicked: {
          storage.clearAll()
          root.isPremiumAccount = !!storage.getValue("isPremium")
          soundManager.clear()
        }
      }
    }
  }
}
