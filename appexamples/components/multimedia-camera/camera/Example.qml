import Felgo
import QtQuick
import QtMultimedia

App {

  Component.onCompleted: {
    camera.active = true
    captureSession.camera = camera
  }

  NavigationStack {
    AppPage {
      title: qsTr("Camera")

      Camera {
        id: camera
        active: false
      }

      CaptureSession {
        id: captureSession
        videoOutput: output
        imageCapture: ImageCapture {
          id: imageCapture
          onImageCaptured: { previewImg.visible = true }
        }
      }

      VideoOutput {
        id: output
        anchors.fill: parent
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          if(!previewImg.visible) {
            imageCapture.capture()
          }
          else {
            previewImg.visible = false
          }
        }
      }

      AppImage {
        id: previewImg
        anchors.fill: output
        fillMode: Image.PreserveAspectFit
        source: imageCapture.preview
        visible: false
      }

    }
  }
}
