import Felgo 3.0
import QtQuick 2.6
// 3d imports
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtSensors 5.9


App {
  // Set screen to portrait in live client app (not needed for normal deployment)
  onInitTheme: nativeUtils.preferredScreenOrientation = NativeUtils.ScreenOrientationPortrait

  RotationSensor {
    id: sensor
    active: true
    // We copy reading to custom property to use behavior on it
    property real readingX: reading ? reading.x : 0
    property real readingY: reading ? reading.y : 0

    // We animate property changes for smoother movement of the cube
    Behavior on readingX { NumberAnimation{ duration: 200 } }
    Behavior on readingY { NumberAnimation{ duration: 200 } }
  }

  NavigationStack {
    Page {
      title: "3D Cube on Page"
      backgroundColor: Theme.secondaryBackgroundColor

      Column {
        padding: dp(15)
        spacing: dp(5)

        AppText {
          text: "x-axis " + sensor.readingX.toFixed(2)
        }

        AppText {
          text: "y-axis " + sensor.readingY.toFixed(2)
        }
      }

      // 3d object on top of camera
      Scene3D {
        id: scene3d
        anchors.fill: parent
        focus: true
        aspects: ["input", "logic"]
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

        Entity {
          // The camera for the 3d world, to view our cube
          Camera {
            id: camera3D
            projectionType: CameraLens.PerspectiveProjection
            fieldOfView: 45
            nearPlane : 0.1
            farPlane : 1000.0
            position: Qt.vector3d( 0.0, 0.0, 40.0 )
            upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
            viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
          }

          components: [
            RenderSettings {
              activeFrameGraph: ForwardRenderer {
                camera: camera3D
                clearColor: "transparent"
              }
            },
            InputSettings { }
          ]

          PhongMaterial {
            id: material
            ambient: Theme.tintColor // Also available are diffuse, specular + shininess to control lighting behavior
          }

          // The 3d mesh for the cube
          CuboidMesh {
            id: cubeMesh
            xExtent: 8
            yExtent: 8
            zExtent: 8
          }

          // Transform (rotate) the cube depending on sensor reading
          Transform {
            id: cubeTransform
            // Create the rotation quaternion from the sensor reading
            rotation: fromAxesAndAngles(Qt.vector3d(1,0,0), sensor.readingX*2, Qt.vector3d(0,1,0), sensor.readingY*2)
          }

          // The actuac 3d cube that consist of a mesh, a material and a transform component
          Entity {
            id: sphereEntity
            components: [ cubeMesh, material, cubeTransform ]
          }
        }
      }

      // Color selection row
      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: dp(5)
        padding: dp(15)

        Repeater {
          model: [ Theme.tintColor, "crimson", "darkolivegreen", "darkorange" ]

          Rectangle {
            color: modelData
            width: dp(48)
            height: dp(48)
            radius: dp(5)

            MouseArea {
              anchors.fill: parent
              onClicked: {
                material.ambient = modelData
              }
            }
          }
        }
      }
    }
  }
}
