import QtQuick 2.6
import Felgo 3.0

FlickablePage {
  id: root

  title: qsTr("Profile Example")
  flickable.contentHeight: content.height

  // Here we are just checking that those items are not blank
  property bool areAllFieldsPopulated: isNotBlank(usernameField.value) && isNotBlank(birthField.value) && isNotBlank(phoneField.value)

  function isNotBlank(value) {
    return value.trim(" ") !== ""
  }

  rightBarItem: TextButtonBarItem {
    text: qsTr("Submit")
    visible: areAllFieldsPopulated
    onClicked: NativeDialog.confirm(qsTr("Success"), qsTr("Profile properties updated"))
  }

  Column {
    id: content
    topPadding: constants.defaultMargins
    anchors { left: parent.left; right: parent.right; }

    Item {
      height: constants.profilePicSize + constants.defaultMargins
      width: parent.width

      RoundedImage {
        id: productImage
        fillMode: AppImage.PreserveAspectCrop
        width: constants.profilePicSize
        height: constants.profilePicSize
        anchors.horizontalCenter: parent.horizontalCenter
        radius: width / 2

        MouseArea {
          anchors.fill: parent

          // displays a native image picker for each platform
          onClicked: nativeUtils.displayImagePicker(qsTr("Pick profile picture"))
        }

        Connections {
          target: nativeUtils

          // here we get notified that our image is ready and we display it
          onImagePickerFinished: {
            if(accepted) productImage.source = path
          }
        }

        // we display a dark overlay with a camera icon
        Rectangle {
          anchors.fill: parent
          radius: width / 2
          color: "#33000000"

          Icon {
            anchors.centerIn: parent
            size: parent.height / 4
            icon: IconType.camera
            color: "white"
          }
        }
      }
    }

    // TextFieldRow contains a AppLabel and a AppTextField wrapped in a SimpleRow
    TextFieldRow {
      id: usernameField
      label: qsTr("Username")
      placeHolder: qsTr("Enter your username")
      textFieldItem.inputMode: textFieldItem.inputModeUsername
    }

    TextFieldRow {
      id: phoneField
      label: qsTr("Phone")
      placeHolder: qsTr("Enter your phone")

      // On mobile, display a customized keyboard with dialable characters
      textFieldItem.inputMethodHints: Qt.ImhDialableCharactersOnly
    }

    TextFieldRow {
      id: birthField
      label: qsTr("Birth Date")
      placeHolder: qsTr("Enter your birth date")

      // instead of requiring the user to manually type a date we just show a native date picker when he/she taps on it.
      clickEnabled: true
      onClicked: nativeUtils.displayDatePicker()

      Connections {
        target: nativeUtils

        // when the date picker returns some data we set the TextInput value
        onDatePickerFinished: {
          if (accepted) birthField.value = convertDateToString(date)
        }

        function convertDateToString(date) {
          return new Date(date).toLocaleDateString(Locale.ShortFormat)
        }
      }
    }
  }
}
