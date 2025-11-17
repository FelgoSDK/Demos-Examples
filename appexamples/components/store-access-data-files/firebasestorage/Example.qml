import Felgo
import QtQuick


App {
  NavigationStack {
    FlickablePage {
      title: "Firebase Storage"
      flickable.contentHeight: column.height

      FirebaseStorage {
        id: storage
      }

      Column {
        id: column
        width: parent.width
        anchors.margins: dp(12)

        AppButton {
          text: "Capture image + upload"
          onClicked: {
            nativeUtils.displayCameraPicker()
          }
        }

        AppText {
          id: status
          text: "Idle"
        }

        // This will display the image after it's uploaded
        AppImage {
          id: img
          width: parent.width
          fillMode: AppImage.PreserveAspectFit
          autoTransform: true
        }
      }
    }
  }

  Connections {
    target: nativeUtils
    function onCameraPickerFinished(accepted, path) {
      if (accepted) {
        // Picture taken with camera is stored in path parameter. Upload it to Firebase Storage
        storage.uploadFile( path, "test-image" + Date.now() + ".png",
                           function(progress, finished, success, downloadUrl) {
                             // Callback function on upload end
                             if (!finished) {
                               status.text = "Uploading... " + progress.toFixed(2) + "%"
                             } else if (success) {
                               img.source = downloadUrl
                               status.text = "Upload completed."
                             } else {
                               status.text = "Upload failed."
                             }
                           } )
      }
    }
  }
}
