import Felgo 4.0
import QtQuick 2.0


App {
  NavigationStack {
    AppPage {
      title: "Camera Picker"

      AppButton {
        flat: false
        anchors.centerIn: parent
        text: "Camera Picker"
        onClicked: {
          nativeUtils.displayCameraPicker()
        }
      }
    }
  }

  Connections {
    target: nativeUtils
    // Let's have a look at this selfie
    function onCameraPickerFinished(accepted, path) {
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
