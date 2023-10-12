import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.2


App {
  NavigationStack {
    Page {
      id: page
      title: "Camera"

      Camera {
        id: camera

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
          exposureCompensation: -1.0
          exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {
          onImageCaptured: {
            // Show the preview in an Image
            photoPreview.source = preview
          }
        }
      }

      VideoOutput {
        autoOrientation: true
        source: camera
        anchors.fill: parent
        // To receive focus and capture key events when visible
        focus: visible
      }

      Image {
        id: photoPreview
      }
    }
  }
}
