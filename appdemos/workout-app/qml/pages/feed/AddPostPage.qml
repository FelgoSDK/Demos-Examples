import Felgo
import QtQuick


AppPage {
  id: root

  title: "Add Post"

  leftBarItem: IconButtonBarItem {
    color: Theme.textColor
    iconType: IconType.close

    onClicked: {
      addPostModal.close()
    }
  }

  rightBarItem: TextButtonBarItem {
    enabled: contentTextEdit.text != "" || updatedImage.source != ""
    color: enabled ? Theme.tintColor : Theme.secondaryTextColor
    text: qsTr("Publish")
    textItem.font.pixelSize: sp(16)

    onClicked: {
      Qt.inputMethod.hide()
      dataModel.addPost(contentTextEdit.text, updatedImage.source)
      addPostModal.close()
    }
  }

  Flickable {
    id: flickable

    anchors.fill: parent

    contentHeight: column.height
    interactive: flickable.contentHeight > flickable.height

    Column {
      id: column

      width: parent.width

      padding: dp(Theme.contentPadding)
      spacing: dp(Theme.contentPadding) * 2

      AppTextEdit {
        id: contentTextEdit

        width: parent.width - parent.padding * 2
        height: contentHeight

        placeholderText: "How do you do?"
        wrapMode: TextEdit.Wrap
      }

      AppImage {
        id: updatedImage

        width: parent.width - parent.padding * 2
        visible: source != ""

        fillMode: Image.PreserveAspectFit
        source: ""

        MouseArea {
          anchors.fill: parent

          onPressAndHold: {
            nativeUtils.displayAlertSheet(qsTr("Edit photo"), ["Change photo", "Remove photo"], true)
          }
        }
      }
    }
  }

  AppPaper {
    id: addPhotoPaper
    height: addPhotoButton.height
    width: parent.width

    anchors.bottom: parent.bottom
    anchors.bottomMargin: app.keyboardVisible ?
                            Qt.inputMethod.keyboardRectangle.height + Theme.statusBarHeight
                          : 0

    IconButton {
      id: addPhotoButton

      anchors.verticalCenter: parent.verticalCenter

      iconType: IconType.photo
      size: dp(20)

      onClicked: {
        nativeUtils.displayImagePicker(qsTr("Photo upload"))
      }
    }
  }

  Connections {
    target: nativeUtils

    function onAlertSheetFinished(index) {
      if (index == 0) {
        nativeUtils.displayImagePicker(qsTr("Photo upload"))
      } else if (index == 1) {
        updatedImage.source = ""
      }
    }

    function onImagePickerFinished(accepted, path) {
      console.debug("Image picker finished with path:", path)
      if (accepted) {
        updatedImage.source = Qt.resolvedUrl(path)
      }
    }
  }

  function reset() {
    contentTextEdit.text = ""
    updatedImage.source = ""
  }

  function forceTyping() {
    contentTextEdit.forceActiveFocus()
  }
}
