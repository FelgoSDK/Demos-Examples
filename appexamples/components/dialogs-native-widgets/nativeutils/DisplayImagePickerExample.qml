import Felgo
import QtQuick


App {
  NavigationStack {
    AppPage {
      title: "Pick image"

      AppButton {
        flat: false
        anchors.centerIn: parent
        text: "Pick image"
        onClicked: {
          nativeUtils.displayImagePicker("Show me your best shot!")
        }
      }
    }
  }

  Connections {
    target: nativeUtils

    // Let's handle the new picture
    function onImagePickerFinished(accepted, path) {
      if (accepted) {
        imageDialog.displayImageDialog(path)
      }
    }
  }

  // A simple dialog for displaying images coming from pickers
  Dialog {
    id: imageDialog
    title: "This looks great"
    onAccepted: close()
    onCanceled: close()

    AppImage {
      id: imageDialogPicture
      anchors {
        fill: parent
        margins: dp(Theme.contentPadding)
      }
      fillMode: Image.PreserveAspectFit
    }

    function displayImageDialog(path) {
      imageDialogPicture.source = path
      imageDialog.open()
    }
  }
}
